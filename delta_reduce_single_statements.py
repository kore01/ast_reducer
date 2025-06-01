import os
import subprocess
import sys
import re
from pathlib import Path
from typing import List

from run_sqlite import run_sqlite

def delta_reduce_single_statements(sql_queries_dir: Path, expected_output_326: str, expected_output_339: str, test_script: Path) -> str:
    curr_sql = ""
    reduced_sql = ""
    pre_next_sql = ""
    post_next_sql = ""
    save_reduced_curr_sql = ""
    print("RUNNING SINGLE STATEMENTS DELTA")

    # Find all matching query_*.sql files
    sql_dir = sql_queries_dir
    query_files = sorted(
        [f for f in sql_dir.glob("query_*.sql") if f.is_file()],
        key=lambda f: int(re.search(r"query_(\d+)\.sql", f.name).group(1))
    )

    for i, curr_path in reversed(list(enumerate(query_files))):
        print(f"post_next_sql: {post_next_sql}")

        next_sql = curr_path.read_text(encoding='utf-8')

        # Collect post_next_sql from all later files
        pre_next_sql = ""
        for later_path in query_files[:i:-1]:
            pre_next_sql = later_path.read_text(encoding='utf-8') + pre_next_sql

        print(f"pre_next_sql: {post_next_sql}")
        
        #try to reduce the sql
        new_sql = reduce(next_sql, 2, "test_script", pre_next_sql, post_next_sql, expected_output_326, expected_output_339)

        print(f"Reduced query: {new_sql}")


        post_next_sql = reduced_sql + '\n' + post_next_sql
        #pre_next_sql += '\n' + reduced_sql
    return "success"

#def reduce_sql(expected_output_326: str, expected_output_339: str, pre_next_sql: str, post_next_sql: str, curr_sql_line: str) -> str:


def reduce(curr_sql_line:str, n: int, test_script: str,
           pre_next_sql: str,  post_next_sql: str,
           expected1: str, expected2: str) -> str:
    print("do reduce")
    print(curr_sql_line)

    if len(curr_sql_line) == 0:
        return curr_sql_line

    if n >= len(curr_sql_line):
        return curr_sql_line

    parts = split(curr_sql_line, n)
    comps = comps_of_split(parts)
    print(parts)
    print(comps)

    for i in range(n):
        delta = parts[i]
        comp = comps[i]
        print(delta)

        if test_for_fail(delta, test_script,
                         pre_next_sql, post_next_sql, 
                         expected1, expected2) == 0:
            print("FAIL 1")
            return reduce(delta, 2, test_script,
                          pre_next_sql, post_next_sql, 
                          expected1, expected2)

        if test_for_fail(comp, test_script,
                         pre_next_sql, post_next_sql, 
                         expected1, expected2) == 0:
            print("FAIL 2")
            return reduce(comp, n - 1, test_script,
                          pre_next_sql, post_next_sql, 
                          expected1, expected2)
    print("FAIL 3")
    return reduce(curr_sql_line, n * 2, test_script,
                  pre_next_sql, post_next_sql, 
                  expected1, expected2)

def split(curr_sql_line: str, n: int) -> List[str]:
    parts = []
    sql_length = len(curr_sql_line) // n

    for i in range(n):
        start = i * sql_length
        if i == n - 1:
            end = len(curr_sql_line)
        else:
            end = (i + 1) * sql_length
        parts.append(curr_sql_line[start:end])

    return parts


def tokenize(sql: str) -> List[str]:
    """
    Simple SQL tokenizer: splits by whitespace and keeps punctuation separate.
    """
    # This regex splits words and punctuation into tokens
    tokens = re.findall(r"\w+|[^\s\w]", sql)
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
        parts.append(part.strip())
    return parts

def comps_of_split(parts: List[str]) -> List[str]:
    comps = []
    for i in range(len(parts)):
        comp = ''
        for j in range(len(parts)):
            if i != j:
                comp += parts[j]
        comps.append(comp)
    return comps

def test_for_fail(sql_query: str, test_script: str,
                  pre_next_sql: str, post_next_sql: str, 
                  expected1: str | None, expected2: str | None) -> int:
    curr_query = pre_next_sql + sql_query + post_next_sql
    try:
        result = subprocess.run(
            [test_script, curr_query],
            capture_output=True,
            text=True,
            check=True
        )
        return int(result.stdout.strip())
    except subprocess.CalledProcessError as e:
        print(f"Script failed with return code {e.returncode}")
        print(f"stderr: {e.stderr}")
        raise
    except ValueError as e:
        print("Failed to convert output to int")
        print(f"Output was: {result.stdout}")
        raise
    
    
    