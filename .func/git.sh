#!/bin/bash


function ghelp() {
	echo -e "gst/st - git status"
	echo -e "gpush - git push"
	echo -e "gpushnew - git push new"

	echo -e "gch - git checkout $1"
	echo -e "gchp - git checkout $1 -> pull"

	echo -e "gcp - git add -> commit -> push"
	echo -e "gcpn - git add -> commit -> push new"

	echo -e "gwipe - git checkout -- ."
}

function st() { 
	git status 
}

function gst() {
	git status
}

function gpush() {
	git push
}

function gpushnew() {
	git push --set-upstream origin $(git symbolic-ref --short -q HEAD)
}

function gcommit() {
	if [ "$#" -ne 1 ]; then
		echo "first argument must be branch name"
		return;
	fi
	git add .
	git status

	read -p "Press enter to continue"
	git commit -m "$1"
}

function gch() {
	if [ "$#" -ne 1 ]; then
		echo "first argument must be branch name"
		return;
	fi
	git checkout $1
}

function gchp() {
	if [ "$#" -ne 1 ]; then
		echo "first argument must be branch name"
		return;
	fi
	git checkout $1 
	git pull
}

function gchpd() {
	gchp develop
}

function gcp() {
	if [ "$#" -ne 1 ]; then
		echo "first argument must be commit message"
		return;
	fi

	git status
	read -p "Press enter to add"
	git add .
	git status

	read -p "Press enter to commit"
	git commit -m "$branch$1"

	read -p "Press enter to push"
	git push
}

function gcpn() {
	if [ "$#" -ne 1 ]; then
		echo "first argument must be commit message"
		return;
	fi

	branch = $(git rev-parse --abbrev-ref HEAD)

	git status
	read -p "Press enter to add"
	git add .
	git status
	read -p "Press enter to commit"
	git commit -m "$1"

	read -p "Press enter to push"
	git push --set-upstream origin $(git symbolic-ref --short -q HEAD)
}

function gwipe() {
	read -p "About to perform 'git checkout -- $1', are you sure?"
	git checkout -- $1
}

function gnew() {
	git checkout -b $1
}
