#!/bin/bash

# new test case
QUERY=${TEST_CASE_LOCATION:-query.sql}

#EXPECTED="Segmentation fault (core dumped)"

EXPECTED_exit_code=139

# if the oracle is a CRASH we just make sure that the reduced sql query still produces the same crash error as with the original_test.sql
# we only have to check if the error is the same for the version where the CRASH happens (resp. we can ignore the other sqlite engine)
version="3.26.0"

# Run the query and capture the output + exit code
output_new=$(sqlite3-"$version" < "$QUERY" 2>&1)
exit_code_new=$?

#echo "$QUERY"
#echo "exit_code_new=$exit_code_new"
#echo "EXPECTED_exit_code=$EXPECTED_exit_code"
#echo "EXPECTED=$EXPECTED"
#echo "output_new=$output_new"

# Explanation of the if clauses:
#1: if the exit codes are not equal than it is not the same crash (this should probably be enough tbf)
if [[ "$exit_code_new" -ne "$EXPECTED_exit_code" ]]; then
    exit 1
else
	echo "We still have a failure (CRASH)!"
    exit 0
fi
