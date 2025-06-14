#!/bin/bash

# new test case
QUERY=${TEST_CASE_LOCATION:-query.sql}

EXPECTED_326="|1.0|0|||11960.1801526769
||1|||3802.84948380511
|1.0|v_bwaja|||8446
|24227.630527005|v_fgzuu|||1.0e+72
||1|||3802.84948380511|
7681
6773
3185
-7634
552"

EXPECTED_339="|1.0|0|||11960.1801526769
||1|||3802.84948380511
|1.0|v_bwaja|||8446
|24227.630527005|v_fgzuu|||1.0e+72
|1.0|0|||11960.1801526769|
7681
6773
3185
-7634
552"

EXPECTED_326_exit_code=0 
EXPECTED_339_exit_code=0

# if the oracle is a DIFF we just make sure that the reduced sql query still makes sure that there is a difference in error ouputs to 
# 3.26.0 and 3.49.0
output_326=$(sqlite3-3.26.0 < "$QUERY" 2>&1)
exit_code_326=$?

output_339=$(sqlite3-3.39.4 < "$QUERY" 2>&1)
exit_code_339=$?

#echo "$QUERY"
#echo "Expected 326: $EXPECTED_326"
#echo "326: $output_326"
#echo "Expected 339: $EXPECTED_339"
#echo "339: $output_339"

# Explanation of the if clauses:
# 1 and 2: exit codes of the original_test output should be equal to the new outputs
# 3: the outputs should differ between output_326 and output_339
# 4 - 5: similarly if the outputs of the two versions changed compared to the old one (original_test) this is also bad
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



