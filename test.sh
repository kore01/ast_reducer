#!/bin/bash

 # original_test.sql
QUERY="$1"
ORACLE=$(cat "$2")
ORIGINAL="$3"
EXPECTED1="$4"
EXPECTED2="$5"

#DIR=$(dirname "$QUERY")
# get the oracle

#ORACLE=$(cat "$DIR/oracle.txt")


#echo "DIR is: $DIR"
#echo "Expected oracle.txt path: $DIR/oracle.txt"

#echo "QUERY: $QUERY"
#echo "ORACLE: $ORACLE"
#echo "ORIGINAL: $ORIGINAL"
#echo "EXPECTED1: $EXPECTED1"
#echo "EXPECTED2: $EXPECTED2"

# if the oracle is a CRASH we just make sure that the reduced sql query still produces the same crash error as with the original_test.sql
if [[ "$ORACLE" =~ CRASH ]]; then
    version=$(echo "$ORACLE" | sed -n 's/CRASH(\(.*\))/\1/p' | tr -d '\r\n')
    #echo "version: $version"

    # Extract saved expected crash result
    output_old=$(cat "$EXPECTED1")
    exit_code_old=$(echo "$output_old" | head -n1 | sed -n 's/\[EXIT CODE:\([0-9]*\)\]/\1/p')
    output_old_body=$(echo "$output_old" | tail -n +2)

    # Run the query and capture the output + exit code
    output_new=$(sqlite3-"$version" < "$QUERY" 2>&1)
    exit_code_new=$?
    echo "[DEBUG $version ]"
    echo "exit_code_old=$exit_code_old"
    echo "exit_code_new=$exit_code_new"
    echo "output_old=$output_old"
    echo "output_old_body=$output_old_body"
    echo "output_new=$output_new"

    #output_new_original=$(sqlite3-"$version" < "$ORIGINAL" 2>&1)
    #echo "output_new_original=$output_new_original"

    # Explanation of the if clauses:
    #1: if the exit codes are not equal than it is not the same crash (this should probably be enough tbf)
    #2: if not the second one just checks if the output is the same (or not)
    if [[ "$exit_code_new" -ne "$exit_code_old" ]]; then
        exit 1
    elif [[ "$output_new" != "$output_old_body" ]]; then
        exit 1
    else
    	echo "We have a failure"
        exit 0
    fi

# if the oracle is a DIFF we just make sure that the reduced sql query still makes sure that there is a difference in error ouputs to 
# 3.26.0 and 3.49.0
elif [[ "$ORACLE" =~ DIFF ]]; then
	
	output_326=$(sqlite3-3.26.0 < "$QUERY" 2>&1)
	exit_code_326=$?
	output_339=$(sqlite3-3.39.4 < "$QUERY" 2>&1)
	exit_code_339=$?

	output_old_326=$(cat "$EXPECTED1")
	exit_code_old_326=$(echo "$output_old_326" | head -n1 | sed -n 's/\[EXIT CODE:\([0-9]*\)\]/\1/p')
    output_old_body_326=$(echo "$output_old_326" | tail -n +2)


    output_old_339=$(cat "$EXPECTED2")
    exit_code_old_339=$(echo "$output_old_339" | head -n1 | sed -n 's/\[EXIT CODE:\([0-9]*\)\]/\1/p')
    output_old_body_339=$(echo "$output_old_339" | tail -n +2)

    echo "[DEBUG 3.26.0 and 3.39.4]"
    echo "exit_code_old_326=$exit_code_old_326"
    echo "exit_code_old_339=$exit_code_old_339"
    echo "exit_code_326=$exit_code_326"
    echo "exit_code_339=$exit_code_339"

    echo "[DEBUG 3.26.0 and 3.39.4]"
    echo "output_old_body_326=$output_old_body_326"
    echo "output_326=$output_339"
    echo "output_old_body_339=$output_old_body_326"
    echo "output_339=$output_339"


	#if echo "$output_326" | grep -iq error && echo "$output_339" | grep -iq error; then
	#    echo "[TEST SCRIPT] Both outputs contain 'error'"
	#    exit 1
	# Explanation of the if clauses:
	# 1 and 2: exit codes of the original_test output should be equal to the new outputs
	# 3: the outputs should differ between output_326 and output_339
	# 4 - 5: similarly if the outputs of the two versions changed compared to the old one (original_test) this is also bad
    if [[ "$exit_code_old_326" -ne "$exit_code_326" ]]; then
        exit 1 
    elif [[ "$exit_code_old_339" -ne "$exit_code_339" ]]; then
        exit 1 
	elif [[ "$output_326" == "$output_339" ]]; then
		exit 1
	elif [[ "$output_326" != "$output_old_body_326" ]]; then
		exit 1
	elif [[ "$output_339" != "$output_old_body_339" ]]; then
		exit 1
	else
		echo "We have a failure"
		exit 0
	fi

else
	echo "Something went wrong!"
	exit 1

fi



