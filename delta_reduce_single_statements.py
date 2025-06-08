from functools import lru_cache
import os
import subprocess
import sys
import re
from pathlib import Path
from typing import List

import tempfile

from remove_redundant_parentheses import remove_redundant_parentheses

def delta_reduce_single_statements(sql_queries_dir: Path, test_script: Path) -> str:
    curr_sql = ""
    reduced_sql = ""
    pre_next_sql = ""
    post_next_sql = ""
    save_reduced_curr_sql = ""

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

        new_sql = reduce(next_sql, 2, test_script, pre_next_sql, post_next_sql, 1)
        new_sql = remove_redundant_parentheses(new_sql)
        if new_sql.strip().endswith(";"):
            post_next_sql = new_sql + post_next_sql
        else:
            post_next_sql = new_sql + ";\n" + post_next_sql
            new_sql = new_sql + ";\n"
        if not post_next_sql.endswith(";"):
            post_next_sql = post_next_sql + ";"

        curr_path.write_text(new_sql)

    return post_next_sql

def reduce(curr_sql_line:str, n: int, test_script: Path, pre_next_sql: str,  post_next_sql: str, depth: int) -> str:

    if len(curr_sql_line) == 0:
        return curr_sql_line

    if n >= len(curr_sql_line):
        return curr_sql_line

    parts = split_token_aware(curr_sql_line, n)
    comps = comps_of_split(parts)
    for i in range(len(parts)):
        delta = parts[i]
        comp = comps[i]

        if test_for_fail(delta, test_script, pre_next_sql, post_next_sql) == 0:
            if(depth > 66): return delta
            return reduce(delta, 2, test_script, pre_next_sql, post_next_sql, depth+1)

        if test_for_fail(comp, test_script, pre_next_sql, post_next_sql) == 0:
            if(depth > 66): return comp
            return reduce(comp, n - 1, test_script, pre_next_sql, post_next_sql, depth+1)
    return reduce(curr_sql_line, n * 2, test_script, pre_next_sql, post_next_sql, depth+1)

@lru_cache(maxsize=14124)
def tokenize(sql: str) -> List[str]:
    # This regex splits words and punctuation into tokens
    tokens = re.findall(r"\w+|[^\s\w]", sql)
    tokens = [tok for tok in tokens if tok != ';' and tok != '']
    return tokens

def split_token_aware(curr_sql_line: str, n: int) -> List[str]:
    tokens = tokenize(curr_sql_line)
    length = len(tokens)
    chunk_size = length // n
    parts = []
    for i in range(n):
        start = i * chunk_size
        if i == n - 1:
            end = length
        else:
            end = (i + 1) * chunk_size
        chunk_tokens = tokens[start:end]
        # Join tokens with spaces except around punctuation
        part = ""
        for t in chunk_tokens:
            if re.match(r"\w+", t):
                # alphanumeric token
                if part and not part.endswith(" "):
                    part += " "
                part += t
            else:
                # punctuation, append directly
                part += t
        if(part.strip()): parts.append(part.strip())
    return parts

def comps_of_split(parts: List[str]) -> List[str]:
    return [" ".join(parts[:i] + parts[i+1:]) for i in range(len(parts))]

@lru_cache(maxsize=14124)
def test_for_fail(sql_query: str, test_script: Path, pre_next_sql: str, post_next_sql: str) -> int:
    if(sql_query == ""):
        curr_query = pre_next_sql +";" + post_next_sql
    elif(sql_query.endswith(";")):
        curr_query = pre_next_sql+";" + sql_query +";" + post_next_sql
    else:
        curr_query = pre_next_sql+";" + sql_query +";" + post_next_sql
       
    try:
        with tempfile.NamedTemporaryFile(mode="w+", suffix=".sql", delete=False) as tmp_file:
            #tmp_file.write(curr_query)
            tmp_file.write(curr_query)
            tmp_file.flush()
            tmp_path = Path(tmp_file.name)

            # Set env var TEST_CASE_LOCATION to tmp_path
            env = os.environ.copy()
            env["TEST_CASE_LOCATION"] = str(tmp_path)

            # Use tmp_path in your subprocess
            result = subprocess.run(
                [str(test_script)],
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
