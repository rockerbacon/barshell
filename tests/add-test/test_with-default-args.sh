#!/bin/bash

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../..")

oneTimeSetUp() {
	# shellcheck source=tests/environment/setup.sh
	source "$project_root/tests/environment/setup.sh"
	output=$(./foopak add-test test 2>&1)
}

oneTimeTearDown() {
	teardown_environment
}

test_should_correctly_create_executable_file() {
	assertTrue \
		"file 'tests/test_test.sh' not found:\n$output\n" \
		"test -f tests/test_test.sh"

	assertTrue \
		"file 'tests/test_test.sh' does not have executable permissions:\n$output\n" \
		"test -x tests/test_test.sh"
}

test_should_correctly_set_project_root() {
	# shellcheck disable=SC2016
	assertContains \
		'project_root=realpath "$(dirname "${BASH_SOURCE[0]}")/.."' \
		"$(cat tests/test_test.sh)"
}

test_should_correctly_set_shunit_command() {
	# shellcheck disable=SC2016
	assertContains \
		'. "$project_root/foopak_modules/barshell/shunit2/shunit2"' \
		"$(cat tests/test_test.sh)"
}

# shellcheck disable=SC1090
. "$project_root/foopak_modules/kward/shunit2/shunit2"

