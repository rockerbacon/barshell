#!/bin/bash

export project_root
export module_root

project_root=$(realpath "$(dirname "${BASH_SOURCE[0]}")/..")
module_root=$project_root

"$project_root/src/analyze.sh" &&
"$project_root/src/tests.sh" &&
echo -e "\nAll checks passed!"

