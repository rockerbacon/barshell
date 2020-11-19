#!/bin/bash

file=${1:?}

echo "INFO: checking indentation for '$file'" >&2

skip_check=$(grep -o -E '#\s*barshell\s+skip-indentation-check' "$file")

if [ -n "$skip_check" ]; then
	echo "INFO: file tagged with 'skip-indentation-check', skipping" >&2
	exit 0
fi

space_indentation=$(grep -n -E '^\s* ' "$file")

if [ -n "$space_indentation" ]; then
	echo "ERROR: file '$file' indented with spaces:" >&2
	echo "$space_indentation" | tr ' ' '.' >&2
	exit 1
fi

echo "INFO: indentation ok" >&2
exit 0

