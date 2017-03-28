FROM quay.io/urzds/xpra:v2.0-alpine-1
MAINTAINER Dennis Schridde <devurandom@gmx.net>

RUN apk add --no-cache \
	'firefox-esr>=45.7' \
	font-noto \
	ttf-dejavu \
	ttf-liberation

VOLUME /home
ENV HOME=/home

#CMD ["/usr/bin/vglrun", "-d :100", "/usr/bin/firefox", "--no-remote"]
CMD ["/usr/bin/firefox", "--no-remote"]
