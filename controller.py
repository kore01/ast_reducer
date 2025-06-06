import shutil
import sys
import os
from pathlib import Path
from delta_reduce_single_statements import delta_reduce_single_statements
from get_sql_statements import get_sql_statements

from run_sqlite import run_sqlite
from simple_changes_single_statement import simple_changes_single_statement


#take the OG path and change it to a copy
query_path = os.path.realpath(sys.argv[1])

dest_path = os.path.join(os.path.dirname(query_path), "result_query.sql")
shutil.copyfile(query_path, dest_path)

query_path = dest_path
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


# If the directory exists, remove all its contents
if sql_queries_dir.exists() and sql_queries_dir.is_dir():
    for item in sql_queries_dir.iterdir():
        if item.is_file() or item.is_symlink():
            item.unlink()
        elif item.is_dir():
            shutil.rmtree(item)

# Ensure the directory exists (create it if it doesn't)
sql_queries_dir.mkdir(parents=True, exist_ok=True)

#sql_queries_dir.mkdir(parents=True, exist_ok=True)
print(f"Created (or already exists): {sql_queries_dir}")
get_sql_statements(query_path)

#run sql versions on the original sql
expected_output_326 = run_sqlite("3.26.0", content)
expected_output_339 = run_sqlite("3.39.4", content)
print(f"The expected_output_339 is:  {expected_output_339}")
print(f"The expected_output_326 is:  {expected_output_326}")

#try to do funcy filtering 

#attempt_all_statements = delta_reduce_many_statements(sql_queries_dir, expected_output_326, expected_output_339, test_path)
#try to delta reduce on all the statements

#expected_output_339 = run_sqlite("3.39.4", ";CREATE TABLE F( p BOOLEAN NOT NULL NULL NOT NULL, i BOOLEAN) ;INSERT INTO F SELECT * FROM (VALUES ((NOT false), false), (NULL, (NOT (NOT true)))) AS L WHERE (((+(+(-((+110) / (+((-(-150)) * ((247 * (91 * (-47))) + (-86)))))))) = ((((+(+(24 / (+((+89) * (+58)))))) * (-(-((193 + 223) / (-(222 / 219)))))) * (34 * 70)) * (+(+((((+(+(-202))) / (+52)) - (-(228 + (-104)))) * (-24)))))) = (false <> (66 <> 8)));")

#WHAT WE WANT TO DO HERE:
#1. try to remove statements with delta (todo)
#2. try to improve the statements (todo)
# - tokenization
# - try to cut off wheres/join/....
#3. try to reduce the single statement with delta (done)
#repeat while the steps improve the result

attempt = simple_changes_single_statement(sql_queries_dir, expected_output_326, expected_output_339, test_path)
attempt2 = delta_reduce_single_statements(sql_queries_dir, expected_output_326, expected_output_339, test_path)
while(attempt2 != content):
    content = attempt
    attempt = simple_changes_single_statement(sql_queries_dir, expected_output_326, expected_output_339, test_path)
    attempt2 = delta_reduce_single_statements(sql_queries_dir, expected_output_326, expected_output_339, test_path)


with open(query_path, "w", encoding="utf-8") as f:
    f.write(content)

