#!/bin/bash

 # original_test.sql
QUERY="$1"
ORACLE="$2"
ORIGINAL="$3"

#DIR=$(dirname "$QUERY")
# get the oracle

#ORACLE=$(cat "$DIR/oracle.txt")


#echo "DIR is: $DIR"
#echo "Expected oracle.txt path: $DIR/oracle.txt"

echo "QUERY: $QUERY"
echo "ORACLE: $ORACLE"
echo "ORIGINAL: $ORIGINAL"

# if the oracle is a CRASH we just make sure that the reduced sql query still produces the same crash error as with the original_test.sql
if [[ "$ORACLE" =~ CRASH ]]; then
	version=$(echo "$oracle" | sed -n 's/CRASH(\(.*\))/\1/p')
	echo "version: $version"

	output_new=$(sqlite3-"$version" < "$QUERY" 2>&1)
	output_old=$(sqlite3-"$version" < "$ORIGINAL" 2>&1)

	if [[ "$output_new" != "$output_old" ]]; then
		exit 0
	else 
		exit 1
	fi
# if the oracle is a DIFF we just make sure that the reduced sql query still makes sure that there is a difference in error ouputs to 
# 3.26.0 and 3.49.0
elif [[ "$ORACLE" =~ DIFF ]]; then
	echo "Hello"
	output_326=$(sqlite3-3.26.0 < "$QUERY" 2>&1)
	echo "OUTPUT_326: $output_326"

	output_old=$(sqlite3-"$version" < "$ORIGINAL" 2>&1)

	output_339=$(sqlite3-3.39.4 < "$QUERY" 2>&1)
	echo "OUTPUT_339: $output_339"

	if echo "$output_326" | grep -iq error && echo "$output_339" | grep -iq error; then
	    echo "[TEST SCRIPT] Both outputs contain 'error'"
	    exit 1 
	elif [[ "$output_326" == "$output_339" ]]; then
		exit 1
	else
		exit 0
	fi

else
	echo "Something went wrong!"
	exit 1

fi



