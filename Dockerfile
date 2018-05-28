FROM quay.io/urzds/xpra:v2.2.6-alpine3_7-1@sha256:9602baae5d1fa0f80e3ae24128ccb61b003b4226c95cde01e12962000b0428ae
MAINTAINER Dennis Schridde <devurandom@gmx.net>

RUN apk add --no-cache \
	'firefox-esr~52.8.0' \
	font-noto \
	ttf-dejavu \
	ttf-liberation

VOLUME /home
ENV HOME=/home \
	XPRA_CHILD="/usr/bin/firefox --no-remote"
