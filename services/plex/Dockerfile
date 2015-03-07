FROM hamiltont/media
MAINTAINER Hamilton Turner <hamiltont@gmail.com>
# Thanks: 
# https://github.com/timhaak/docker-plex/blob/master/Dockerfile
# https://github.com/bydavy/docker-plex/blob/master/Dockerfile
# https://github.com/aostanin/docker-plex/blob/master/Dockerfile

RUN apt-get update && \ 
 apt-get install -yy wget procps && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* && \
 rm -rf /tmp/*

# Environment variables are explained at 
#   https://support.plex.tv/hc/en-us/articles/200273978-Linux-User-and-Storage-configuration 

# What user to run as
#  - See hamitont/media image
ENV PLEX_MEDIA_SERVER_USER $MEDIA_USER
# Where PMS and libraries are installed
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver
# Where to store logs,database,settings,plugins,etc
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /plex
# How many plugins processes can run at the same time
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 3
# Where to store transcodes
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp
ENV TMPDIR $PLEX_MEDIA_SERVER_TMPDIR
# Where plex can find libraries (*.so files)
ENV LD_LIBRARY_PATH $PLEX_MEDIA_SERVER_HOME
# Max stack size (in kbytes)
ENV PLEX_MEDIA_SERVER_MAX_STACK_SIZE 10000
# Allowed open files
ENV PLEX_MEDIA_SERVER_MAX_OPEN_FILES 4096

# Custom version variable
ENV PLEX_VER 0.9.11.13.874-dd72b17
# Custom var for presetting allowed networks
ENV PLEX_HOSTNET 10.0.0.24/255.255.255.0

RUN wget https://downloads.plex.tv/plex-media-server/${PLEX_VER}/plexmediaserver_${PLEX_VER}_amd64.deb && \
 dpkg -i plexmediaserver_${PLEX_VER}_amd64.deb && \
 rm -f plexmediaserver_${PLEX_VER}_amd64.deb

RUN apt-get update && \
 apt-get install -yy dbus avahi-daemon avahi-utils supervisor && \
 dbus-uuidgen --ensure && \
 mkdir -p /var/run/dbus && \
 mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/plex.conf

ADD ./start.sh /start.sh
RUN chmod a+x /start.sh && \
 chown $MEDIA_USER:$MEDIA_GROUP /start.sh && \
 mkdir -p $PLEX_MEDIA_SERVER_HOME $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR && \
 chown -R $MEDIA_USER:$MEDIA_GROUP $PLEX_MEDIA_SERVER_HOME $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR 

EXPOSE 32400

# USER $MEDIA_USER

VOLUME ["/plex"]

# Don't use start_pms
#   See https://forums.plex.tv/index.php/topic/151458-issues-in-start-pms-script/
CMD ["/start.sh"]
