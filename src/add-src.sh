#!/bin/bash

file_path=$1; shift

formatted_file_path=${project_root:?}/src/${file_path%.sh}

mkdir -p "$(dirname "$formatted_file_path")"

cp "${module_root:?}/templates/src.sh" "${formatted_file_path}.sh"

