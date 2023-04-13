#!/bin/bash


## CLI args
ESYNC_LOCALPATH="${ARGS[0]}"
ESYNC_ADDRESS="${ARGS[1]}"
ESYNC_REMOTEPATH="${ARGS[2]}"
ESYNC_RSYNC_ARGS_OVERRIDE="${@:4}"


##------------------------------------------------------------------------------


## Replace variable if it matches an alias
## - $1: variable to replace
## - $2: alias to look for
## - $3: replacement value if alias matches
sshalias () {
	if [ "${1}" == "${2}" ]; then
		echo "${3}"
	else
		echo "${1}"
	fi
}
