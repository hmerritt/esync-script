#!/bin/bash


VERSION="0.1.8"


##------------------------------------------------------------------------------


SCRIPT_PATH=`dirname "$(readlink -f "$0")"`
SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"


##------------------------------------------------------------------------------


CONFIG_DIR="${HOME}/.config"
CONFIG_PATH="${CONFIG_DIR}/esync.config"


CURRENT_ACTION=""
CURRENT_TASK=""


ERROR=""
