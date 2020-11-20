#!/bin/bash

test_path_arg=$1

if [ -z "$project_root" ]; then
	project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/..")
fi

tests_root="$project_root/tests"

lean_test_path_arg=${test_path_arg#./}
lean_test_path_arg=${lean_test_path_arg#tests}
lean_test_path_arg=${lean_test_path_arg#/}
lean_test_path_arg=${lean_test_path_arg%.sh}

if [ -n "$lean_test_path_arg" ]; then
	tests_dir="$project_root/tests/$lean_test_path_arg"
	test_file="$project_root/tests/$lean_test_path_arg.sh"
else
	tests_dir=$tests_root
fi

exec_single_test() {
	local test_script=$1

	local slim_test_name=${test_script#$tests_root/}

	echo "$test_script,$slim_test_name,$tests_dir" >&2

	echo "Running '$slim_test_name'" 1>&2
	"$test_script" 1>&2
	local exit_status=$?
	if [ "$exit_status" != "0" ]; then
		echo -e "\t* $slim_test_name"
	fi

	export retval0
	retval0="$exit_status"
	return $retval0
}

if [ ! -e "$test_file" ] && [ ! -e "$tests_dir" ]; then
	echo "ERROR: could not find file or directory '$tests_dir'" >&2
	exit 1
fi

echo -e "\n######## STARTING TESTS ########\n" >&2

if [ -f "$test_file" ]; then

	if [ ! -x "$test_file" ]; then

		slim_test_name=${test_file#$tests_dir/}

		echo "ERROR: no executable permission for '$slim_test_name'" >&2
		failures="\t* $slim_test_name"

	else

		failures=$(exec_single_test "$test_file")

	fi

else

	failures=$(
		find "$tests_dir" \
			-name '*test_*.sh' |
		while read -r test_script; do
			exec_single_test "$test_script"
		done
	)

fi

echo
if [ -n "$failures" ]; then
	echo -e "The following tests failed:" >&2
	echo "$failures" >&2
	exit_status=1
else
	echo "All tests passed!"
	exit_status=0
fi

echo -e "\n######## ENDING TESTS ########\n" >&2

exit $exit_status

