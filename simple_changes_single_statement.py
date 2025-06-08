from functools import lru_cache
import os
import subprocess
import sys
import re
from pathlib import Path
from typing import List

import tempfile

from delta_reduce_single_statements import test_for_fail
from remove_redundant_parentheses import remove_redundant_parentheses
from remove_select_args import remove_select_args
from remove_where_args import remove_where_args
from remove_with_args import remove_with_args
from replace_nth_bracket_expression_random import replace_nth_bracket_expression_random
from replace_nth_bracket_expression_random import replace_nth_bracket_expression_random


def simple_changes_single_statement(sql_queries_dir: Path, test_script: Path) -> str:
    curr_sql = ""
    reduced_sql = ""
    pre_next_sql = ""
    post_next_sql = ""
    save_reduced_curr_sql = ""
    #print("RUNNING SINGLE STATEMENTS SQLBLOP")

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
            if not post_next_sql.endswith(";"):
                post_next_sql = post_next_sql + ";"
                
            if os.path.isfile(curr_path):
                os.remove(curr_path)
            #print(f"reduced to empty: {new_sql}")
            
        
        else:
            # Replace hex numbers like 0x123abc
            #next_sql = re.sub(r"0x[0-9a-fA-F]+", "0", next_sql)
            # Replace binary blobs like x'FF'
            #next_sql = re.sub(r"[xX]'[0-9a-fA-F]*'", "'BLOB'", next_sql)

            new_sql = next_sql
            new_sql = remove_redundant_parentheses(new_sql)
            new_sql = reduce_where(new_sql, test_script, pre_next_sql, post_next_sql)
            new_sql = reduce_select(new_sql, test_script, pre_next_sql, post_next_sql)
            new_sql = reduce_in_brackets(new_sql, test_script, pre_next_sql, post_next_sql)
            new_sql2 = reduce_with(new_sql, test_script, pre_next_sql, post_next_sql)
         
            while(new_sql2 != new_sql):
                new_sql = new_sql2
                new_sql2 = reduce_with(new_sql, test_script, pre_next_sql, post_next_sql)
                
            #new_sql = reduce(next_sql, 2, test_script, pre_next_sql, post_next_sql, expected_output_326, expected_output_339, 1)
            #new_sql = remove_redundant_parentheses(new_sql)
            if new_sql.strip().endswith(";"):
                post_next_sql = new_sql + post_next_sql
            else:
                post_next_sql = new_sql + ";\n" + post_next_sql
                new_sql = new_sql + ";\n"
            if not post_next_sql.endswith(";"):
                post_next_sql = post_next_sql + ";"
            curr_path.write_text(new_sql)

    return post_next_sql

#def reduce_sql(expected_output_326: str, expected_output_339: str, pre_next_sql: str, post_next_sql: str, curr_sql_line: str) -> str:
def reduce_where(curr_sql_line:str, test_script: Path, pre_next_sql: str,  post_next_sql: str) -> str:
    

    if len(curr_sql_line) == 0:
        return curr_sql_line

    curr_removed = remove_where_args(curr_sql_line, -1)
    if curr_removed == "": return curr_sql_line
    if test_for_fail(curr_removed, test_script, pre_next_sql, post_next_sql) == 0:
            return curr_removed

    i = 0
    while(1):
        curr_removed = remove_where_args(curr_sql_line, i)
        if curr_removed == "": break
        #if it doesnt fail, then 
        if test_for_fail(curr_removed, test_script, pre_next_sql, post_next_sql) == 0:
            curr_sql_line = curr_removed
        else: i+=1
    
    return curr_sql_line  


def reduce_select(curr_sql_line:str, test_script: Path, pre_next_sql: str,  post_next_sql: str) -> str:
    if len(curr_sql_line) == 0:
        return curr_sql_line

    i = 0
    while(1):
        curr_removed = remove_select_args(curr_sql_line, i)
        if curr_removed == "": break
        if(curr_sql_line == curr_removed): 
            i+=1
            continue
        #if it doesnt fail, then 
        if test_for_fail(curr_removed, test_script, pre_next_sql, post_next_sql) == 0:
            curr_sql_line = curr_removed
            
        else: i+=1
    
    return curr_sql_line  


def reduce_with(curr_sql_line:str, test_script: Path,
           pre_next_sql: str,  post_next_sql: str) -> str:
    if len(curr_sql_line) == 0:
        return curr_sql_line

    i = 1
    while(1):
        curr_removed = remove_with_args(curr_sql_line, i)
        if curr_removed == "": break
        if(curr_sql_line == curr_removed): 
            i+=1
            continue
        #if it doesnt fail, then 
        if test_for_fail(curr_removed, test_script, pre_next_sql, post_next_sql) == 0:
            curr_sql_line = curr_removed
        else: i+=1
    
    return curr_sql_line  


import random

def reduce_in_brackets(curr_sql_line: str, test_script: Path, pre_next_sql: str, post_next_sql: str) -> str:
    if len(curr_sql_line) == 0:
        return curr_sql_line

    i = 0
    while True:
        try:
            curr_removed, curr_true, curr_false = replace_nth_bracket_expression_random(curr_sql_line, i)
        except IndexError:
            # No more bracket expressions at index i
            break

        if curr_removed == "":
            break

        if(curr_true != curr_sql_line):
             if test_for_fail(curr_true, test_script, pre_next_sql, post_next_sql) == 0:
                curr_sql_line = curr_true
                continue
        
        if(curr_false != curr_sql_line):
             if test_for_fail(curr_false, test_script, pre_next_sql, post_next_sql) == 0:
                curr_sql_line = curr_false
                continue
             
        if curr_removed == curr_sql_line:
            i+=1
            continue
        # If the test passes (returns 0), accept the reduction
        if test_for_fail(curr_removed, test_script, pre_next_sql, post_next_sql) == 0:
            curr_sql_line = curr_removed
        else:
            i += 1

    return curr_sql_line
