#!/bin/bash

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/..")

cd "$project_root" || return 1

rm -rf /tmp/barshell_test_environments

