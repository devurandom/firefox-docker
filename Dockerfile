FROM ubuntu:14.04
MAINTAINER Dennis Schridde <devurandom@gmx.net>

VOLUME /home

RUN apt-get -y install software-properties-common && apt-add-repository multiverse

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true | debconf-set-selections

RUN apt-get update && apt-get -y install --install-recommends firefox=36.0.1* flashplugin-installer=11.2.202.451* dbus-x11 pulseaudio gstreamer1.0-pulseaudio gstreamer1.0-plugins-good ubuntu-restricted-extras

RUN groupadd -g 1000 storage && useradd -u 1000 -g storage storage

USER storage

CMD ["/usr/bin/firefox" ,"-new-instance"]
