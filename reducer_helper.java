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
        Path sql_query = Paths.get(args[0]);
        System.out.println("SQL Query path: " + sql_query.toAbsolutePath());

        // we get the path to the testscript folder where our original_test.sql is
        String test = args[1];

        // we get the path to the query folder to get to oracle.txt
        Path oracleFile = sql_query.getParent().resolve("oracle.txt");
		System.out.println("Oracle path: " + oracleFile.toAbsolutePath());

        // we get the original_test as a string without newlines (to not confuse the split function to create deltas with a lot of spaces)
        String original_test = Files.readString(sql_query).replace("\n", "").replace("\r", "");  

        // we also get the oracle as a String for later
        String oracle = Files.readString(oracleFile);

        // This is what we want to get, the reduced sql query of the original_test.sql, which we want to save in the same parent directory
		String reduced_sql = reduce(original_test, 2, testScript, oracle, original_test);
        Path reducedPath = sql_query.getParent();.resolve("reduced.sql");
        Files.write(reducedPath, reduced_sql.getBytes(StandardCharsets.UTF_8));
        System.out.println("Reduced query written to: " + reducedPath);
    }

    private static String reduce(String curr_sql_line, int n, String testScript, String oracle, String original_test_sql) throws IOException, InterruptedException {
	    if (curr_sql_line.length()==0){ 
	    	return curr_sql_line;
	    }


	  	// create parts for a sql query
	    List<String> parts = split(curr_sql_line, n);
	    
	    // create comps of said parts
	    List<String> comps = comps_of_split(parts);


        for (int i = 0; i < n; i++) {
            // if there is a failure when taking delta_i as reduced sql query then....
            if (test_for_fail(parts.get(i), testScript, oracle, original_test_sql) == 0) {
                // call reduce with said delta and n = 2 
                return reduce(parts.get(i), 2, testScript, oracle);
            }
            // if there is a failure when taking the complement of delta_i as reduced sql query then....
            if (test_for_fail(comps.get(i), testScript, oracle, original_test_sql) == 0) {
                // call reduce with said complement of delta and n = n -1
                return reduce(comps.get(i), n - 1, testScript, oracle);
            }
        }

        // now if we reached a granularity of n = to the length of the current reduced sql query, we know there is nothing we can reduce further.
        if(n >= curr_sql_line.length()){
            return curr_sql_line;
        } 
        else{
            // if there is still "reduction potential" we just adapt the value n, we multiply it by a factor of 2 (as described in the algo as well)
            return reduce(curr_sql_line, n * 2, testScript, oracle, original_test_sql);
        }

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

    private static int test_for_fail(String sql_query, String testScript, String oracle, String original_test_sql) throws IOException, InterruptedException {
            
        // creates and deletes temporary files for the test_for_fail process
        // this could be optimized maybe
        File tmp_query = File.createTempFile("tmp_query", ".sql");
        File tmp_oracle = File.createTempFile("tmp_oracle", ".txt");
        File tmp_old_query = File.createTempFile("tmp_old_query", ".sql");

        Files.write(tmp_query.toPath(), sql_query.getBytes(StandardCharsets.UTF_8));
        Files.write(tmp_oracle.toPath(), oracle.getBytes(StandardCharsets.UTF_8));
        Files.write(tmp_old_query.toPath(), original_test_sql.getBytes(StandardCharsets.UTF_8));

        ProcessBuilder pb = new ProcessBuilder(testScript, tmp_query.getAbsolutePath(), oracle, tmp_old_query.getAbsolutePath());
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

        // delete the temporary folders
        tmp_query.delete();
        tmp_oracle.delete();
        tmp_old_query.delete();

        // return the result (eithr exit code 0 or 1)
        return result;
    }
}
