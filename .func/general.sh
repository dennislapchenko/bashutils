#!/bin/bash


#halp='f(){ curl cheat.sh/$1; unset -f f; }; f' example of a function within alias if need be

function halp() {
	curl cheat.sh/$1;
}

function foreach() {
	for i in {1..$1}; do $2; done
}

function mkdircd() {
	mkdir -p $1 && cd $1
}

function clip() {
	cat $1 | pbcopy
}

function awkp() {
	awk '{print $'$1'}'
}

function awkpr() {
	awk 'FNR == '$1' {print $'$2'}'
}

function genrsa() {
	if [ "$#" -ne 2 ]; then
		echo "2 arguments are required: key name and bits (2048, 4086, etc)"
		return;
	fi
	openssl genrsa -out $1.key $2;
	openssl rsa -in $1.key -pubout -out $1.key.pub
	echo "Generated $1.key"
	echo "Generated $1.key.pub"
}

function genrsasimple() {
	if [ "$#" -ne 2 ]; then
		echo "2 arguments are required: key name and bits (2048, 4086, etc)"
		return;
	fi
	ssh-keygen -t rsa -b $2 -C $1 -f $1.key
	echo "Generated $1.key"
	echo "Generated $1.key.pub"
}

function addprivatekey() {
	if [ "$#" -ne 1 ]; then
		echo "1 arguments is required: private key name"
		return;
	fi
	ssh-add -K $1
}

sedi () {
    sed --version >/dev/null 2>&1 && sed -i -- "$@" || sed -i "" "$@"
}