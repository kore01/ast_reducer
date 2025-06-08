#!/bin/bash

# new test case
QUERY="$1"

#EXPECTED_326="1|2025-06-01 12:15:55"
#EXPECTED_326="1|"
EXPECTED_326_PATTERN='^1\|[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'
EXPECTED_339=""

EXPECTED_326_exit_code=0 
EXPECTED_339_exit_code=0

# if the oracle is a DIFF we just make sure that the reduced sql query still makes sure that there is a difference in error ouputs to 
# 3.26.0 and 3.49.0
output_326=$(sqlite3-3.26.0 < "$QUERY" 2>&1)
exit_code_326=$?

output_339=$(sqlite3-3.39.4 < "$QUERY" 2>&1)
exit_code_339=$?

#echo "EXPECTED_326_PATTERN: $EXPECTED_326_PATTERN"
echo "326: $output_326"
#echo "Expected 339: $EXPECTED_339"
echo "339: $output_339"

echo "$exit_code_339"
echo "$exit_code_326"

# Explanation of the if clauses:
# 1 and 2: exit codes of the original_test output should be equal to the new outputs
# 3: the outputs should differ between output_326 and output_339
# 4 - 5: similarly if the outputs of the two versions changed compared to the old one (original_test) this is also bad
if [[ "$EXPECTED_326_exit_code" -ne "$exit_code_326" ]]; then
	echo "something is off with error code 326"
    exit 1 
elif [[ "$EXPECTED_339_exit_code" -ne "$exit_code_339" ]]; then
	echo "something is off with error code 339"
    exit 1 
elif [[ "$output_326" == "$output_339" ]]; then
	echo "326 is the same as 339"
	exit 1
#elif [[ "$output_326" != *"$EXPECTED_326"* ]]; then
#	exit 1
elif ! printf "%s" "$output_326" | grep -Pq "$EXPECTED_326_PATTERN"; then
    echo "Output 326 does not match expected date/time pattern"
    exit 1
elif [[ "$output_339" != *"$EXPECTED_339"* ]]; then
	echo "Output 339 is off"
	exit 1
else
	echo "We still have a failure (DIFF)!"
	exit 0
fi
