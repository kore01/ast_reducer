import sys
import os
from pathlib import Path
from delta_reduce_single_statements import delta_reduce_single_statements
from get_sql_statements import get_sql_statements
from run_sqlite import run_sqlite



query_path = os.path.realpath(sys.argv[1])
test_path = os.path.realpath(sys.argv[2])
print(f"Reading: {query_path}")

with open(query_path, "r", encoding="utf-8") as f:
    content = f.read()
    print(content)


#separate query into separate files
# Path to your SQL file
sql_file_path = Path(query_path)
parent_dir = sql_file_path.parent
sql_queries_dir = parent_dir / "sql_queries"
sql_queries_dir.mkdir(parents=True, exist_ok=True)
print(f"Created (or already exists): {sql_queries_dir}")
get_sql_statements(query_path)

#run sql versions on the original sql
expected_output_326 = run_sqlite("3.26.0", content)
expected_output_339 = run_sqlite("3.39.4", content)
print(f"The expected_output_339 is:  {expected_output_339}")
print(f"The expected_output_326 is:  {expected_output_326}")

#try to do funcy filtering 

#try to delta reduce on all the statements

#try to delta reduce single statements
attempt = delta_reduce_single_statements(sql_queries_dir, expected_output_326, expected_output_339, test_path)
print(attempt)

#tokenization?