#!/bin/bash

set -x
set -e

CONTAINER_IMAGE=quay.io/devurandom/firefox
FIREFOX_STORAGE="${HOME}"/firefox-storage

container_exists() {
	local container_name="$1"
	docker ps -a | awk '$NF=="'"${container_name}"'"{found=1} END{if(!found){exit 1}}'
}

#declare -a dri_devices
#for d in `find /dev/dri -type c` ; do
#	dri_devices+=(--device "${d}")
#done

docker_address="$(ip address show dev docker0 | egrep '\<inet\>' | awk '{print$2}' | cut -d/ -f1)"

docker pull "${CONTAINER_IMAGE}"

docker run --detach --publish 30000:14500 --user "$(id -u):$(id -g)" --volume "${FIREFOX_STORAGE}":/home:rw --volume /var/run/nscd/socket:/var/run/nscd/socket:rw --volume /var/run/cups/cups.sock:/var/run/cups/cups.sock:rw --volume /etc/localtime:/etc/localtime:ro --volume /etc/timezone:/etc/timezone:ro --env XPRA_EXTRA_ARGS="--tcp-auth= --tcp-encryption=" --env SOCKS_SERVER="${docker_address}:5080" --env SOCKS_VERSION=5 "${dri_devices[@]}" "${CONTAINER_IMAGE}" "$@"

while ! curl --silent http://localhost:30000/Status | grep --quiet 'Message: this port does not support HTTP requests.' ; do
	sleep 1
done

exec xpra attach tcp/localhost:30000
