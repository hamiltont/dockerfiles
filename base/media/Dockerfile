FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

# Setup language
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8

# HTTPS requires ca-certificates
# Locale-gen needs locales
RUN apt-get update && \ 
 apt-get install -yy ca-certificates adduser locales && \
 locale-gen $LANG && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* && \
 rm -rf /tmp/*


ENV MEDIA_USER media
ENV MEDIA_UID  5000
ENV MEDIA_GROUP $MEDIA_USER
ENV MEDIA_GID  5000


RUN groupadd --gid $MEDIA_GID $MEDIA_GROUP && \
 adduser --disabled-password --uid $MEDIA_UID --gid $MEDIA_GID --gecos '' $MEDIA_USER && \
 chown media:media /media

ENV TERM xterm
RUN apt-get update && \ 
 apt-get install -yy nano vim wget net-tools less htop sudo && \
 locale-gen $LANG && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* && \
 rm -rf /tmp/*

# No devices should be mounted inside a container anyway, 
# so I don't feel too bad for occupying the /media mount
VOLUME ["/media"]
