#!/bin/bash

# new test case
QUERY="$1"

#EXPECTED="Segmentation fault (core dumped)"
#EXPECTED=""

#EXPECTED_339="0|1|26|
#0|0|72|
#1|1|62|
#1|0|74|
#"

EXPECTED_exit_code=139
#EXPECTED_339_exit_code=0


# if the oracle is a CRASH we just make sure that the reduced sql query still produces the same crash error as with the original_test.sql
version="3.26.0"

# Run the query and capture the output + exit code
output_new=$(sqlite3-"$version" < "$QUERY" 2>&1)
exit_code_new=$?

echo "[DEBUG $version ]"
echo "exit_code_new=$exit_code_new"
echo "EXPECTED_exit_code=$EXPECTED_exit_code"
echo "EXPECTED=$EXPECTED"
echo "output_new=$output_new"

#output_new_original=$(sqlite3-"$version" < "$ORIGINAL" 2>&1)
#echo "output_new_original=$output_new_original"

# Explanation of the if clauses:
#1: if the exit codes are not equal than it is not the same crash (this should probably be enough tbf)
#2: if not the second one just checks if the output is the same (or not)
if [[ "$exit_code_new" -ne "$EXPECTED_exit_code" ]]; then
    exit 1
#elif [[ "$output_new" != *"$EXPECTED"* ]]; then
#    exit 1
else
	echo "We have a failure"
    exit 0
fi
