#!/bin/bash

analyze_file() {
	local file_path=${1:?}

	"${module_root:?}/src/check_indentation.sh" "$file_path"
	local indentation_status=$?

	shellcheck -x "$file_path"
	local shellcheck_status=$?

	export retval0
	retval0=$((indentation_status + shellcheck_status))
	return $retval0
}

analyze_directory() {
	local directory=${1:?}
	local analysis_status=0

	restore_workdir=$PWD
	cd "${project_root:?}" || exit 1

		while read -r file_path; do
			analyze_file "$file_path"

			if [ "$retval0" != "0" ]; then
				analysis_status="$retval0"
			fi
		done < <(find "./$directory" -name '*.sh')

	cd "$restore_workdir" || exit 1

	export retval0=$analysis_status
	return $retval0
}

echo "######## STARTING ANALYSIS ########" >&2

directory=$1

exit_status=0
if [ -z "$directory" ]; then
	analyze_directory src || exit_status=1
	analyze_directory tests || exit_status=1
	analyze_directory ci || exit_status=1
else
	analyze_directory "$directory" || exit_status=1
fi

echo "######## ENDING ANALYSIS ########" >&2

exit "$exit_status"

