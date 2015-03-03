FROM ubuntu:14.04
MAINTAINER Dennis Schridde <devurandom@gmx.net>

VOLUME /home

RUN apt-get -y install software-properties-common && apt-add-repository multiverse

RUN apt-get update && apt-get -y install firefox=36.0* flashplugin-installer=11.2.202.442* gstreamer1.0-pulseaudio gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly

RUN groupadd -g 1000 storage && useradd -u 1000 -g storage storage

USER storage

CMD ["/usr/bin/firefox" ,"-new-instance"]
