#!/bin/bash

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../..")

oneTimeSetUp() {
	# shellcheck source=tests/setup_environment.sh
	source "$project_root/tests/setup_environment.sh"
	output=$(./foopak add-src test_src 2>&1)
}

oneTimeTearDown() {
	teardown_environment
}

test_should_correctly_create_file() {
	assertTrue \
		"file 'src/test_src.sh' not found:\n$output\n" \
		"test -f src/test_src.sh"
}

# shellcheck disable=SC1090
. "$project_root/foopak_modules/kward/shunit2/shunit2"

