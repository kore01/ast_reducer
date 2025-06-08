from functools import lru_cache
import os
import subprocess
import sys
import re
from pathlib import Path
from typing import List

import sqlglot
from sqlglot.errors import TokenError, ParseError

import tempfile

from remove_redundant_parentheses import remove_redundant_parentheses

def remove_redundant(sql_queries_dir: Path, test_script: Path) -> str:
    curr_sql = ""
    reduced_sql = ""
    pre_next_sql = ""
    post_next_sql = ""
    save_reduced_curr_sql = ""
    print("...trying to remove redundant sql queries...")

    # Find all matching query_*.sql files
    sql_dir = sql_queries_dir
    query_files = sorted(
        [f for f in sql_dir.glob("query_*.sql") if f.is_file()],
        key=lambda f: int(re.search(r"query_(\d+)\.sql", f.name).group(1))
    )
    post_next_sql = ""

    for i, curr_path in reversed(list(enumerate(query_files))):

        next_sql = curr_path.read_text(encoding='utf-8')

        # Collect post_next_sql from all later files
        pre_next_sql = ""
        for j in range(i-1, -1, -1):
            later_path = query_files[j]
            pre_next_sql = later_path.read_text(encoding='utf-8') + pre_next_sql

        
        #try to reduce the sql
        if test_for_fail("", test_script, pre_next_sql, post_next_sql) == 0:
            new_sql = ""
            post_next_sql = new_sql + post_next_sql
                
            if os.path.isfile(curr_path):
                os.remove(curr_path)
        else:
            post_next_sql = next_sql + post_next_sql
    
    print(f"Reduced query: {post_next_sql}")
    return post_next_sql


@lru_cache(maxsize=14124)
def test_for_fail(sql_query: str, test_script: Path, pre_next_sql: str, post_next_sql: str) -> int:
    curr_query = pre_next_sql + post_next_sql

    try:
        with tempfile.NamedTemporaryFile(mode="w+", suffix=".sql", delete=False) as tmp_file:
            tmp_file.write(curr_query)
            tmp_file.flush()
            tmp_path = Path(tmp_file.name)

            # Use tmp_path in your subprocess
            result = subprocess.run(
                [str(test_script), str(tmp_path)],
                capture_output=True,
                text=True,
                check=False
            )
            tmp_path.unlink()
        return result.returncode
    except subprocess.CalledProcessError as e:
        print(f"Script failed with return code {e.returncode}")
        print(f"stderr: {e.stderr}")
        raise
    except ValueError as e:
        print("Failed to convert output to int")
        print(f"Output was: {result.stdout}")
        raise