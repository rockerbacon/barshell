#!/bin/bash

if [ -z "$project_root" ]; then
	project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/..")
fi
tests_dir="$project_root/tests"

echo -e "\n######## STARTING TESTS ########\n"

failures=$(
	find "$tests_dir" \
		-name '*test_*.sh' |
	while read -r test_script; do
		slim_test_name=${test_script/$tests_dir\//}

		echo "Running '$slim_test_name'" 1>&2
		bash "$test_script" 1>&2
		exit_status=$?
		if [ "$exit_status" != "0" ]; then
			echo -e "\t* $slim_test_name"
		fi
	done
)

echo
if [ -n "$failures" ]; then
	echo -e "The following tests failed:"
	echo "$failures"
	exit 1
fi

echo "All tests passed!"

echo -e "\n######## ENDING TESTS ########\n"

