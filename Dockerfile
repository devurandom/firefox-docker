FROM ubuntu:14.04
MAINTAINER Dennis Schridde <devurandom@gmx.net>

VOLUME /home

# Add multiverse repository
RUN apt-get -y install software-properties-common && apt-add-repository multiverse

# Allow installation of corefonts
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true | debconf-set-selections

# Install Firefox, Flash and everything required for HTML5 Video
RUN apt-get update && apt-get -y install --install-recommends firefox=38.0* flashplugin-installer=11.2.202.468* dbus-x11 pulseaudio gstreamer1.0-pulseaudio gstreamer1.0-plugins-good ubuntu-restricted-extras

# Add non-superuser
RUN groupadd -g 1000 storage && useradd -u 1000 -g storage storage

USER storage

CMD ["/usr/bin/firefox" ,"-new-instance"]
