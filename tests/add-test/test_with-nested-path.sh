#!/bin/bash

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../..")

oneTimeSetUp() {
	# shellcheck source=tests/environment/setup.sh
	source "$project_root/tests/environment/setup.sh"
	output=$(./foopak add-test subtest/test_src 2>&1)
}

oneTimeTearDown() {
	teardown_environment
}

test_should_correctly_create_file() {
	assertTrue \
		"file 'tests/subtest/test_src.sh' not found:\n$output\n" \
		"test -f tests/subtest/test_src.sh"
}

test_should_correctly_set_project_root() {
	# shellcheck disable=SC2016
	assertContains \
		'project_root=realpath "$(dirname "${BASH_SOURCE[0]}")/.."' \
		"$(cat tests/subtest/test_test.sh)"
}

test_should_correctly_set_shunit_command() {
	# shellcheck disable=SC2016
	assertContains \
		'. "$project_root/foopak_modules/barshell/shunit2/shunit2"' \
		"$(cat tests/subtest/test_test.sh)"
}


# shellcheck disable=SC1090
. "$project_root/foopak_modules/kward/shunit2/shunit2"

