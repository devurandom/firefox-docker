FROM quay.io/urzds/xpra:v2.1.1-alpine3_6-1
MAINTAINER Dennis Schridde <devurandom@gmx.net>

RUN apk add --no-cache \
	'firefox-esr>=52.2' \
	font-noto \
	ttf-dejavu \
	ttf-liberation

VOLUME /home
ENV HOME=/home

#CMD ["/usr/bin/vglrun", "-d :100", "/usr/bin/firefox", "--no-remote"]
CMD ["/usr/bin/firefox", "--no-remote"]
