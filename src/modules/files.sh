#!/bin/bash


## Move a file to another location
## - $1: path to original file
## - $2: path of new file
move () {
	mv "${1}" "${2}"
}


## Check if a file exists
## -$1: path to file
isfile () {
	if [ -f "${1}" ]; then
		return 0
	else
		return 1
	fi
}


## Check if a directory exists
## -$1: path to directory
isdirectory () {
	if [ -d "${1}" ]; then
		return 0
	else
		return 1
	fi
}
