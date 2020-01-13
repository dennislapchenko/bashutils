#!/bin/sh

function knamespace() {
	k config set-context $(kcurr) --namespace=$1
}

function kcurl() {
	k run curl-$1 --image=radial/busyboxplus:curl -i --tty --rm
}