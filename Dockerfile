FROM ubuntu:14.04
MAINTAINER Dennis Schridde <devurandom@gmx.net>

VOLUME /home

RUN sed -r '/# deb(-src)? .* multiverse$/s/^# deb/deb/' -i /etc/apt/sources.list

RUN apt-get update && apt-get -y install pulseaudio firefox=36.0* flashplugin-installer=11.2.202.442*

RUN groupadd -g 1000 storage && useradd -u 1000 -g storage storage

USER storage

CMD ["/usr/bin/firefox" ,"-new-instance"]
