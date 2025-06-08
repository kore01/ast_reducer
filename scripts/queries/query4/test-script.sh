#!/bin/bash

# Determine query file location
QUERY=${TEST_CASE_LOCATION:-query.sql}

EXPECTED_326="|0.0|5
-403961669||3
-403961669|0.0|6
-403961669|0.0|1
-403961669|0.0|2
-403961669|0.0|4
-403961669|0.0|7"

EXPECTED_339="|0.0|1
-403961669||2
-403961669|0.0|3
-403961669|0.0|4
-403961669|0.0|5
-403961669|0.0|6
-403961669|0.0|7"

EXPECTED_326_exit_code=0 
EXPECTED_339_exit_code=0

output_326=$(sqlite3-3.26.0 < "$QUERY" 2>&1)
exit_code_326=$?

output_339=$(sqlite3-3.39.4 < "$QUERY" 2>&1)
exit_code_339=$?

if [[ "$EXPECTED_326_exit_code" -ne "$exit_code_326" ]]; then
    exit 1 
elif [[ "$EXPECTED_339_exit_code" -ne "$exit_code_339" ]]; then
    exit 1 
elif [[ "$output_326" == "$output_339" ]]; then
	exit 1
elif [[ "$output_326" != "$EXPECTED_326" ]]; then
	exit 1
elif [[ "$output_339" != "$EXPECTED_339" ]]; then
	exit 1
else
	echo "We still have a failure (DIFF)!"
	exit 0
fi
