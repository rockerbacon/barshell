#!/bin/bash

script_dir=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
dev_environment=$(realpath "$script_dir/../..")

mkdir -p /tmp/barshell_test_environments
test_environment=$(mktemp -d /tmp/barshell_test_environments/XXXXXX)

reset_environment() {
	rm -rf "${test_environment:?}"/foopak_modules/barshell/* "${test_environment:?}"/foopak_modules/barshell/.[!.]*

	cp -R "${dev_environment:?}"/* "${dev_environment:?}"/.[!.]* "${test_environment:?}/foopak_modules/barshell/"
	cp "${dev_environment:?}/tests/environment/foopak" "$test_environment/"
	cp -R "${dev_environment:?}/tests" "$test_environment/"
}

teardown_environment() {
	cd "$dev_environment" || return 1
	rm -rf "$test_environment"
}

mkdir -p "$test_environment/foopak_modules/barshell"
reset_environment
cd "$test_environment" || return 1
git init

