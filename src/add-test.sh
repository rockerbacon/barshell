#!/bin/bash

file_path=${1%.sh}; shift

file_dir=${project_root:?}/tests/$(dirname "$file_path")
file_name=${file_path##*/}.sh

mkdir -p "$file_dir"

cp "${module_root:?}/templates/test.sh" "$file_dir/$file_name"

$relative_module_root=${module_root#$project_root}
$escaped_relative_module_root=${relative_module_root/\//\/\/}

sed -i "s/<%relative_module_root%>/$escaped_relative_module_root/g" "$file_dir/$file_name"

