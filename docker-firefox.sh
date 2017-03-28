#!/bin/bash

set -x
set -e

container_exists() {
	local container_name="$1"
	docker ps -a | awk '$NF=="'"${container_name}"'"{found=1} END{if(!found){exit 1}}'
}

#declare -a dri_devices
#for d in `find /dev/dri -type c` ; do
#	dri_devices+=(--device "${d}")
#done

docker_address="$(ip address show dev docker0 | egrep '\<inet\>' | awk '{print$2}' | cut -d/ -f1)"

docker run --detach --publish 30000:14500 --user "$(id -u):1000" --volume "${HOME}"/firefox-storage:/home/user:rw --env XPRA_EXTRA_ARGS="--tcp-auth= --tcp-encryption=" --env HOME=/home --env CUPS_SERVER="${docker_address}" --env SOCKS_SERVER="${docker_address}:5080" --env SOCKS_VERSION=5 "${dri_devices[@]}" --volume /etc/localtime:/etc/localtimeXX:ro --volume /etc/timezone:/etc/timezoneXX:ro devurandom/firefox "$@"

while ! nc -z localhost 30000 ; do
	sleep 1
done

exec xpra attach tcp:localhost:30000
