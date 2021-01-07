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


	## Update script to latest version
	## (overwrites itself)
	if [ "${ARGS[0]}" == "update" ]; then
		task "Update script to latest version"

		actionsub "Checking for newer version"
		github_tags_url="https://api.github.com/repos/hmerritt/esync-script/tags"
		version_latest=$(curl -s "${github_tags_url}" | grep -Po -m 1 '[^v]*[0-9]\.[0-9]\.[0-9]')
		onfail "" "${version_latest}"
		result "ok"

		## Compare current version with latest
		## Prevents needless update
		if [ "${VERSION//.}" -ge "${version_latest//.}" ]; then
			echo
			green "No new update available"
			green "-> v${version_latest} is latest"
			echo
			exit 0
		fi

		actionsub "Fetching latest version"
		github_file="https://github.com/hmerritt/esync-script/releases/download/v${version_latest}/esync.sh"
		cd "/var/tmp" || "/tmp"
		ERROR=$(curl -L "${github_file}" -o "esync.sh" 2>&1)
		onfail "" "${ERROR}"

		## Varify downloaded file
		first_line=$(head -n 1 "esync.sh")
		if [ "${first_line}" != "#!/bin/bash" ]; then
			echo
			error "Failed to fetch latest version: v${version_latest}"
			error "-> Could not verify downloaded file"
			echo
			warning "You could try fetching it manually from GitHub"
			warning "${github_file}"
			echo
			failure "Update failed"

			rm "esync.sh"
			exit 1
		fi
		onfail
		result "ok"

		actionsub "Replacing script with newer version"
		ERROR=$(mv "esync.sh" "${SCRIPT_PATH}/${SCRIPT_NAME}" 2>&1)
		onfail "" "${ERROR}"
		ERROR=$(chmod +x "${SCRIPT_PATH}/${SCRIPT_NAME}" 2>&1)
		onfail "" "${ERROR}"
		result "ok"

		echo
		green "Updated: ${VERSION} --> ${version_latest}"

		echo
		success "Update complete"
		exit
	fi


fi
