#!/bin/bash

# barshell skip-indentation-check

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../..")

oneTimeSetUp() {
	# shellcheck source=tests/environment/setup.sh
	source "$project_root/tests/environment/setup.sh"

	mkdir src
cat << EOF > src/fixture_file.sh
#!/bin/sh
  if space_indented_line; then
    space_indented_command
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

test_should_inform_file_was_incorrectly_indented() {
	assertContains \
		"did not inform incorrect indentation:\n$output\n\n" \
		"$output" \
		"file './src/fixture_file.sh' indented with spaces"
}

# shellcheck disable=SC1090
. "$project_root/foopak_modules/kward/shunit2/shunit2"

