#!/bin/bash

src_dir=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../src")

"$src_dir/check_indentation.sh" &&
# "$src_dir/shellcheck.sh" &&
"$src_dir/tests.sh" &&
echo -e "\nAll checks passed!"

