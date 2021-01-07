#!/bin/bash


ARGS=("$@")


## Import modules
source "modules/module-loader.sh"
loadmodules "${modules}" "modules"


##------------------------------------------------------------------------------


## Check if
if [ "${#ARGS[1]}" == "0" ]; then


	## Print script version
	if [ "${ARGS[0]}" == "version" ]; then
		green "esync [Version ${VERSION}]\n"
		exit
	fi


	## Install script dependencies
	if [ "${ARGS[0]}" == "install" ]; then
		task "Install script dependencies"

		actionsub "Update package repo"
		ERROR=$(apt-get update -y 2>&1)
		onfail "" "Are you root?"
		result "ok"

		actionsub "Install rsync"
		ERROR=$(apt-get install rsync -y 2>&1)
		onfail "" "${ERROR}"
		result "ok"

		echo
		success "Install complete"
		exit
	fi


fi
