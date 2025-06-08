import os
import sys
import re
from pathlib import Path
from functools import lru_cache
from typing import List

import subprocess
import time

@lru_cache(maxsize=14124)
def tokenize(sql: str) -> List[str]:
    # This regex splits words and punctuation into tokens
    tokens = re.findall(r"\w+|[^\s\w]", sql)
    tokens = [tok for tok in tokens if tok != ';' and tok != '']
    return tokens

def calc_quality():
    #path = "/usr/bin/queries-to-minimize/queries"

    quality_per = []
    time_reduces = []

    for i in range(1,21,1):
        print(f"i: {i}")
        
        # Get speed of reduction
        # Build the command as a list
        cmd = [
            "sudo",
            "./reducer",
            "--query", f"/usr/bin/queries-to-minimize/queries/query{i}/original_test.sql",
            "--test", f"/usr/bin/scripts/queries/query{i}/test-script.sh"
        ]

        print(f"cmd: {cmd}")

        # Measure time
        start_time = time.time()

        # Run the command
        subprocess.run(cmd, check=True)

        # Stop time
        end_time = time.time()

        # Calculate elapsed time
        time_reduction = end_time - start_time
        time_reduces.insert(i, time_reduction)

        #################################
        # Get quality of reduction

        path = Path(os.environ["TEST_CASE_LOCATION"])

        input_path1 = Path(path + f"/query{i}/original_test.sql")
        input_path2 = Path(path + f"/query{i}/query.sql")
    
        # Read the file content
        with input_path1.open("r", encoding="utf-8") as f:
            original_test = f.read()

        with input_path2.open("r", encoding="utf-8") as f:
            reduced_test = f.read()

        # get the tokens from original_test
        tokens_original = len(tokenize(original_test))

        # get the tokens from reduced_test
        tokens_reduced = len(tokenize(reduced_test))

        percentage_quality_reduction = ((tokens_original - tokens_reduced) / tokens_original) * 100.0
        quality_per.insert(i, percentage_quality_reduction)

    for i in range(1,21,1):
        print(f"Quality reduction of 'query_{i}': {quality_per[i]:.2f}%.")
        print(f"time needed to reduce 'query_{i}': {time_reduces[i]}.")


if __name__ == '__main__':
    calc_quality()