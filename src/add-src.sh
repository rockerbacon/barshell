#!/bin/bash

file_path=${1%.sh}; shift

file_dir=${project_root:?}/src/$(dirname "$file_path")
file_name=${file_path##*/}.sh

mkdir -p "$file_dir"

cp "${module_root:?}/templates/src.sh" "$file_dir/$file_name"

