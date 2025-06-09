import shutil
import sys
import os
from pathlib import Path
from delta_reduce_single_statements import delta_reduce_single_statements, tokenize
from get_sql_statements import get_sql_statements

from simple_changes_single_statement import simple_changes_single_statement
from remove_redundant import remove_redundant

import time

#take the OG path and change it to a copy
query_path = os.path.realpath(sys.argv[1])

dest_path = os.path.join(os.path.dirname(query_path), "query.sql")
shutil.copyfile(query_path, dest_path)

query_path = dest_path
test_path = os.path.realpath(sys.argv[2])
#print(f"Reading: {query_path}")

with open(query_path, "r", encoding="utf-8") as f:
    content = f.read()

original_test = content
#print(f"original_test: {original_test}")
# get the tokens from original_test
tokens_original = len(tokenize(original_test))

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

print(f"Created (or already exists): {sql_queries_dir}")
get_sql_statements(query_path)

#WHAT WE WANT TO DO HERE:
#1. try to remove statements with delta (todo)
#2. try to improve the statements (todo)
# - tokenization
# - try to cut off wheres/join/....
#3. try to reduce the single statement with delta (done)
#repeat while the steps improve the result


# Measure time
start_time = time.time()


attempt = remove_redundant(sql_queries_dir, test_path)
attempt1 = simple_changes_single_statement(sql_queries_dir, test_path)
attempt2 = delta_reduce_single_statements(sql_queries_dir, test_path)

while(attempt2 != content):
    content = attempt2
    attempt = remove_redundant(sql_queries_dir, test_path)
    attempt = simple_changes_single_statement(sql_queries_dir, test_path)
    attempt2 = delta_reduce_single_statements(sql_queries_dir, test_path)
    attempt = simple_changes_single_statement(sql_queries_dir, test_path)
    attempt2 = delta_reduce_single_statements(sql_queries_dir, test_path)


# Stop time
end_time = time.time()

# Calculate elapsed time
time_reduction = end_time - start_time

#print(f"query.sql: {content}")
reduced_test = content

# get the tokens from reduced_test
tokens_reduced = len(tokenize(reduced_test))

percentage_quality_reduction = ((tokens_original - tokens_reduced) / tokens_original) * 100.0


print(f"Quality reduction of '{str(query_path)}': {percentage_quality_reduction:.2f}%.")
print(f"time needed to reduce '{str(query_path)}': {time_reduction} sec.")

with open(query_path, "w", encoding="utf-8") as f:
    f.write(content)
    env = os.environ.copy()
    env["TEST_CASE_LOCATION"] = str(query_path)
    os.environ.update(env)
