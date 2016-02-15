#!/bin/bash

container_exists() {
	local container_name="$1"
	docker ps -a | awk '$NF=="'"${container_name}"'"{found=1} END{if(!found){exit 1}}'
}

set -e

xhost +local:

if ! container_exists storage ; then
	docker run --name storage devurandom/storage
fi

declare -a dri_devices
for d in `find /dev/dri -type c` ; do
	dri_devices+=(--device "${d}")
done
exec docker run --rm --volumes-from storage --env SOCKS_SERVER="socks://172.17.0.1:5080" --env SOCKS_VERSION=5 --env DISPLAY="${DISPLAY}" --volume /tmp/.X11-unix:/tmp/.X11-unix --env PULSE_SERVER="unix:/tmp/pulse-unix" --volume /run/user/"${UID}"/pulse/native:/tmp/pulse-unix "${dri_devices[@]}" --volume /etc/localtime:/etc/localtime:ro --volume /etc/timezone:/etc/timezone:ro devurandom/firefox "$@"
