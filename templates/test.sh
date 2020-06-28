#!/bin/bash

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../..")

oneTimeSetUp() {

}

oneTimeTearDown() {

}

test_something() {

}

. "$project_root/<%relative_module_root%>/shunit2/shunit2"

