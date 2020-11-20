#!/bin/bash

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../..")

oneTimeSetUp() {
	# shellcheck source=tests/environment/setup.sh
	source "$project_root/tests/environment/setup.sh"

	mkdir src
cat << EOF > src/fixture_file.sh
#!/bin/sh
	# missing quotes around unassigned variable
	if [ -n \$exec_cmd ]; then
		command
	fi
EOF

	output=$(./foopak analyze src 2>&1); exit_code=$?
}

oneTimeTearDown() {
	teardown_environment
}

test_should_exit_with_error_code() {
	assertNotEquals "exited with success code:\n$output\n\n" "0" "$exit_code"
}

test_should_output_shellcheck_errors_and_warnings() {
	assertContains \
		"$output" \
		"SC2070"

	assertContains \
		"$output" \
		"SC2154"

	assertContains \
		"$output" \
		"SC2086"
}

# shellcheck disable=SC1090
. "$project_root/foopak_modules/kward/shunit2/shunit2"

