import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.nio.charset.StandardCharsets;


public class reducer_helper {

    public static void main(String[] args) throws IOException, InterruptedException {

        // one could omit this since the reducer_helper is called from reducer.sh (so if that is correctly coded this error should not happen)
        if (args.length != 2) {
            System.err.println("Usage: java reducer_helper <query.sql> <test_script_path>");
            System.exit(1);
        }

        // we get the path to the query folder where our original_test.sql is
        Path sql_query_path = Paths.get(args[0]);
        System.out.println("SQL Query path: " + sql_query_path.toAbsolutePath());

        /*Path oracle_path = sql_query_path.getParent().resolve("oracle.txt");
        System.out.println("Oracle path: " + oracle_path.toAbsolutePath());*/

        // we get the path to the testscript folder where our original_test.sql is
        String test = args[1];

        // we get the path to the query folder to get to oracle.txt
        /*String original_test = Files.readString(sql_query_path);
        String oracle = Files.readString(oracle_path);

        // Create reusable temp files for oracle and original test
        Path oracleTempPath = Files.createTempFile("oracle", ".txt");
        Files.write(oracleTempPath, oracle.getBytes(StandardCharsets.UTF_8));
        Path originalTestTempPath = Files.createTempFile("original_test", ".sql");
        Files.write(originalTestTempPath, original_test.getBytes(StandardCharsets.UTF_8));*/

        // Read and reduce SQL query parts from sql_queries/query_i.sql
        Path sql_queries = sql_query_path.getParent().resolve("sql_queries");
        // if sql_queries does not exist already, create it please:
        if (!Files.exists(sql_queries) || !Files.isDirectory(sql_queries)) {
            System.out.println("sql_queries not found");
            System.out.println("Running get_sql_statements.py...");

            // call the python 
            ProcessBuilder pb = new ProcessBuilder(
                "python3",
                "/usr/bin/get_sql_statements.py",  // absolute path to the script
                sql_query_path.toString()
            );


            // Set working directory to the same parent as original_test
            pb.directory(sql_query_path.getParent().toFile());

            // Merge stderr with stdout (optional)
            pb.redirectErrorStream(true);

            // Start and capture output
            Process process = pb.start();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    System.out.println("[PYTHON] " + line);
                }
            }

            int exitCode = process.waitFor();
            if (exitCode != 0) {
                System.err.println("Python script failed with exit code " + exitCode);
                System.exit(1);
            }

            System.out.println("sql_queries successfully created.");
        }



        File[] files = sql_queries.toFile().listFiles((dir, name) -> name.startsWith("query_") && name.endsWith(".sql"));
        
        int order = files.length;
        if (files == null || files.length == 0) {
            System.err.println("No query files found in: " + sql_queries);
            System.exit(1);
        }

        //StringBuilder curr_sql = new StringBuilder();
        String curr_sql = "";
        String reduced_sql = "";

        String pre_next_sql = "";
        String post_next_sql = "";

        String save_reduced_curr_sql = "";

        System.out.println(order);
        for (int i = order; i >= 1; i--) {

            // Build pre_next_sql: we attach to pre_next_sql the reduced sql from the query before
            //System.out.println("pre_next_sql: " + pre_next_sql);
            

            // build the path to the next sql query
            Path next_sql_path = sql_query_path.getParent().resolve("sql_queries/query_" + i + ".sql");
            // read next sql query
            String next_sql = Files.readString(next_sql_path);

            // Build pre_next_sql: query_(i+1) to query_(order)
            for (int j = 1; j < i; j++) {
                Path path = sql_query_path.getParent().resolve("sql_queries/query_" + j + ".sql");
                pre_next_sql = pre_next_sql + Files.readString(path);
            }

            //System.out.println("post_next_sql: " + post_next_sql);

            // If completely excluding the next_sql query actually gives us the same exit code as including it (resp. there still exists a failure), we can just reduce to the empty string (we do not need it to preserve the error)
            // we can do this to simply speed up the reduce process
            if(test_for_fail("", test, pre_next_sql, post_next_sql) == 0){
                reduced_sql = "";
            }
            else{
                reduced_sql = reduce(next_sql, 2, test, pre_next_sql, post_next_sql);
            }

            System.out.println("Reduced query: " + reduced_sql);

            // Build pre_next_sql: we attach to pre_next_sql the reduced sql from the query before
            pre_next_sql = "";

            // we set post_next_sql again to the empty string
            post_next_sql = reduced_sql + post_next_sql;
        }

        // since pre_next_sql actually also contains all our reduced sqls we have our reduced.sql
        System.out.println("Reduced original_test: " + post_next_sql);
        Path reduced_path = sql_query_path.getParent().resolve("reduced.sql");
        Files.write(reduced_path, post_next_sql.getBytes(StandardCharsets.UTF_8));
        System.out.println("Reduced query written to: " + reduced_path);

        // Cleanup temp files
        //Files.deleteIfExists(oracleTempPath);
        //Files.deleteIfExists(originalTestTempPath);
    }


    private static String reduce(String curr_sql_line, int n, String testScript, String pre_next_sql, String post_next_sql) throws IOException, InterruptedException {
	    
        if (curr_sql_line.length()==0){ 
	    	return curr_sql_line;
	    }

        // now if we reached a granularity of n = to the length of the current reduced sql query, we know there is nothing we can reduce further.
        if(n >= curr_sql_line.length()){
            return curr_sql_line;
        } 

	  	// create parts for the current sql query
	    List<String> parts = split(curr_sql_line, n);

	    // create comps of said parts
	    List<String> comps = comps_of_split(parts);

        for (int i = 0; i < n; i++) {
            // if there is a failure when taking delta_i as reduced sql query then....
            if (test_for_fail(parts.get(i), testScript, pre_next_sql, post_next_sql) == 0) {
                // call reduce with said delta and n = 2 
                return reduce(parts.get(i), 2, testScript, pre_next_sql, post_next_sql);
            }
            // if there is a failure when taking the complement of delta_i as reduced sql query then....
            if (test_for_fail(comps.get(i), testScript, pre_next_sql, post_next_sql) == 0) {
                // call reduce with said complement of delta and n = n -1
                return reduce(comps.get(i), n - 1, testScript, pre_next_sql, post_next_sql);
            }
        }

        // now if we reached a granularity of n = to the length of the current reduced sql query, we know there is nothing we can reduce further.
        //if(n >= curr_sql_line.length()){
        //    return curr_sql_line;
        //} 
        //else{
        // if there is still "reduction potential" we just adapt the value n, we multiply it by a factor of 2 (as described in the algo as well)
        return reduce(curr_sql_line, n * 2, testScript, pre_next_sql, post_next_sql);
        //}

    }

    // creates the deltas for our delta debugging algorithm
    private static List<String> split(String curr_sql_line, int n) {
      List<String> parts = new ArrayList<>();
        
      int sql_length = curr_sql_line.length() / n;
      int start = 0;
      int end = 0;
      for (int i = 0; i < n; i++) {
          start = i * sql_length;
          if(i == n-1){
          	end = curr_sql_line.length();
          }
          else{
          	end = (i+1) * sql_length;
          }
          
          parts.add(curr_sql_line.substring(start, end));
      }
      
      return parts;

    }

    // creates the complementary of the deltas for our delta debugging algorithm
    private static List<String> comps_of_split(List<String> parts) {
        List<String> comps = new ArrayList<>();
        for (int i = 0; i < parts.size(); i++) {
        		String comp = "";
            for (int j = 0; j < parts.size(); j++) {
                if (i != j){
                	comp = comp + parts.get(j);
                }
            }
            comps.add(comp);
        }
        return comps;
    }

    //private static int test_for_fail(String sql_query, String testScript, String oracle, String original_test_sql) throws IOException, InterruptedException {
    private static int test_for_fail(String sql_query, String testScript, String pre_next_sql, String post_next_sql) throws IOException, InterruptedException {
        // creates temporary query file
        Path tmpQuery = Files.createTempFile("tmp_query", ".sql");

        // create the reduced part to test
        String temp_reduced = pre_next_sql + sql_query + post_next_sql;
        Files.write(tmpQuery, temp_reduced.getBytes(StandardCharsets.UTF_8));

        //ProcessBuilder pb = new ProcessBuilder(testScript, tmpQuery.toString(), oracle_path, original_test_path);
        ProcessBuilder pb = new ProcessBuilder(testScript, tmpQuery.toString());

        pb.redirectErrorStream(true);
        Process proc = pb.start();

        // Read output from what happens inside test if you want
        /*
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(proc.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println("[TEST SCRIPT] " + line);
            }
        }*/

        proc.waitFor();
        int result = proc.exitValue();

        // deletes temp query file
        Files.deleteIfExists(tmpQuery);

        return result;
    }

    /*
    private static String run_sqlite(String version, String sqlContent) throws IOException, InterruptedException {
        Path tmpSql = Files.createTempFile("run_sqlite", ".sql");
        Files.write(tmpSql, sqlContent.getBytes(StandardCharsets.UTF_8));

        ProcessBuilder pb = new ProcessBuilder("sqlite3-" + version);
        pb.redirectErrorStream(true);
        pb.redirectInput(tmpSql.toFile());

        Process proc = pb.start();

        StringBuilder output = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(proc.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line).append("\n");
            }
        }

        int exitCode = proc.waitFor();
        Files.deleteIfExists(tmpSql);

        // Always log this for debugging
        System.out.println("[DEBUG] exit code: " + exitCode);
        System.out.println("[DEBUG] output:\n" + output.toString());

        // include exit code in output marker for CRASH detection
        return "[EXIT CODE:" + exitCode + "]\n" + output.toString();
    }*/


}
