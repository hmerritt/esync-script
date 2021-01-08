#!/bin/bash


VERSION="0.1.2"


##------------------------------------------------------------------------------


SCRIPT_PATH=`dirname "$(readlink -f "$0")"`
SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"


##------------------------------------------------------------------------------


CONFIG_PATH="${ARGS[0]}"


CURRENT_ACTION=""
CURRENT_TASK=""


ERROR=""
