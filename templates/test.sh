#!/bin/bash

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")<%exit_depth%>/..")

oneTimeSetUp() {

}

oneTimeTearDown() {

}

test_something() {

}

# shellcheck disable=SC1090
. "$project_root/<%relative_module_root%>/shunit2/shunit2"

