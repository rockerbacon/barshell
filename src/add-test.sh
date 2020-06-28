#!/bin/bash

file_path=$1; shift

file_dir=${project_root:?}/tests/$(dirname "$file_path")

raw_file_name=${file_path##*/}
file_name_without_prefix=${raw_file_name#test_}
clean_file_name=${file_name_without_prefix%.sh}
file_name=test_$clean_file_name.sh

depth=$(grep -o "/" <<< "$file_path" | wc -l)

if [ "$depth" -gt 0 ]; then
	exit_depth=$(bash -c "printf '%.0s\\/..' {1..$depth}")
fi

mkdir -p "$file_dir"

cp "${module_root:?}/templates/test.sh" "$file_dir/$file_name"

relative_module_root=${module_root#$project_root/}
escaped_relative_module_root=${relative_module_root/\//\\\/}

sed -i \
	-e "s/<%relative_module_root%>/$escaped_relative_module_root/g" \
	-e "s/<%exit_depth%>/$exit_depth/g" \
	"$file_dir/$file_name"

