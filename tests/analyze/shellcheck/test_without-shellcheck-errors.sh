#!/bin/bash

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../..")

oneTimeSetUp() {
	# shellcheck source=tests/environment/setup.sh
	source "$project_root/tests/environment/setup.sh"

	mkdir src
cat << EOF > src/fixture_file.sh
#!/bin/sh
	exec_cmd=\$1
	if [ -n "\$exec_cmd" ]; then
		command
	fi
EOF

	output=$(./foopak analyze src 2>&1); exit_code=$?
}

oneTimeTearDown() {
	teardown_environment
}

test_should_exit_with_success_code() {
	assertEquals "exited with error code '$exit_code':\n$output\n\n" "0" "$exit_code"
}

test_should_inform_shellcheck_analysis_was_done() {
	assertContains \
		"$output" \
		"Analyzing './src/fixture_file.sh'"

	assertContains \
		"$output" \
		"shellcheck analysis ok"
}

# shellcheck disable=SC1090
. "$project_root/foopak_modules/kward/shunit2/shunit2"

