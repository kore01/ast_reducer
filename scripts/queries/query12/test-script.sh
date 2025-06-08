#!/bin/bash

# new test case
QUERY="$1"

EXPECTED_326="56.52|0|66.16|2013-06-17|48\||"

EXPECTED_339="-80.89|1|-46.44|2008-05-08|[/l+]K|"

EXPECTED_326_exit_code=0 
EXPECTED_339_exit_code=0

# if the oracle is a DIFF we just make sure that the reduced sql query still makes sure that there is a difference in error ouputs to 
# 3.26.0 and 3.49.0
output_326=$(sqlite3-3.26.0 < "$QUERY" 2>&1)
exit_code_326=$?
output_339=$(sqlite3-3.39.4 < "$QUERY" 2>&1)
exit_code_339=$?

output_326_clean=$(echo "$output_326" | tr -cd '\11\12\15\40-\176')
EXPECTED_326_clean=$(echo "$EXPECTED_326" | tr -cd '\11\12\15\40-\176')
output_339_clean=$(echo "$output_339" | tr -cd '\11\12\15\40-\176')
EXPECTED_339_clean=$(echo "$EXPECTED_339" | tr -cd '\11\12\15\40-\176')

echo "Expected 326: $EXPECTED_326_clean"
echo "326: $output_326_clean"
echo "Expected 339: $EXPECTED_339_clean"
echo "339: $output_339_clean"

# Explanation of the if clauses:
# 1 and 2: exit codes of the original_test output should be equal to the new outputs
# 3: the outputs should differ between output_326 and output_339
# 4 - 5: similarly if the outputs of the two versions changed compared to the old one (original_test) this is also bad
if [[ "$EXPECTED_326_exit_code" -ne "$exit_code_326" ]]; then
    exit 1 
elif [[ "$EXPECTED_339_exit_code" -ne "$exit_code_339" ]]; then
    exit 1 
elif [[ "$output_326_clean" == "$output_339_clean" ]]; then
    exit 1
elif [[ "$output_326_clean" != *"$EXPECTED_326_clean"* ]]; then
    echo "why this 326"
    exit 1
elif [[ "$output_339_clean" != *"$EXPECTED_339_clean"* ]]; then
    echo "why this 339"
    exit 1
else
    echo "Expected 326: $EXPECTED_326"
    echo "326: $output_326"
    echo "Expected 339: $EXPECTED_339"
    echo "339: $output_339"
    echo "We still have a failure (DIFF)!"
    exit 0
fi

