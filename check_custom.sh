#!/bin/bash

# A small plugin to execute multiple plugin calls
# definend in a local file. Essentially a simpler check_multi.

# For debugging enable the following
# set -x

# For testing
# PLUGINCONTRIBDIR="."

# PLUGINCONTRIBDIR="/usr/lib/nagios/plugins/contrib"
# CUSTOM_COMMAND_FILE="$PLUGINCONTRIBDIR/processes_to_check.txt"
CUSTOM_COMMAND_FILE="./example_config.txt"

EXIT_OK=0

OUTPUT=""
ERROR_OUTPUT=""
declare -g RESULT
RESULT=$EXIT_OK

set_result() {
	if [ "$1" -gt "$RESULT" ]; then
		RESULT=$1
	fi
}

set_output() {
	if [ "$1" -eq 1 ]; then
		ERROR_OUTPUT+="[Warning] $2"
		ERROR_OUTPUT+='\n'
	elif [ "$1" -eq 2 ]; then
		ERROR_OUTPUT+="[Critical] $2"
		ERROR_OUTPUT+='\n'
	elif [ "$1" -ge 2 ]; then
		ERROR_OUTPUT+="[Unkown] $2"
		ERROR_OUTPUT+='\n'
	else
		OUTPUT+="[OK] $2"
		OUTPUT+='\n'
	fi
}

if [ ! -f  $CUSTOM_COMMAND_FILE ]; then
	echo "Custom command file not present."
	exit 0
fi

while read -r line; do
	TMP=$(eval "$line")
	TMP_RESULT=$?
	set_result $TMP_RESULT
	set_output $TMP_RESULT "$TMP"
done < $CUSTOM_COMMAND_FILE

if [ -n "$ERROR_OUTPUT" ]; then
	echo -e "$ERROR_OUTPUT"
fi
if [ -n "$OUTPUT" ]; then
	echo -e "$OUTPUT"
fi

exit "$RESULT"
