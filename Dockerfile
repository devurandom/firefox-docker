FROM quay.io/urzds/xpra:v2.1.1-alpine3_6-1
MAINTAINER Dennis Schridde <devurandom@gmx.net>

RUN apk add --no-cache \
	'firefox-esr>=52.3' \
	font-noto \
	ttf-dejavu \
	ttf-liberation

VOLUME /home
ENV HOME=/home \
	XPRA_CHILD="/usr/bin/firefox --no-remote"
