FROM hamiltont/media
MAINTAINER Hamilton Turner <hamiltont@gmail.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
 echo "deb http://apt.sonarr.tv/ develop main" >> /etc/apt/sources.list && \
 apt-get update && \
 apt-get install -y nzbdrone mediainfo && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run Ahead-of-time compilation on all DLLs and EXEs
#   See http://www.mono-project.com/docs/advanced/aot/
#   Note: Avoid using -O=all with *.dlls inside /opt/NzbDrone, can cause segfaults
#   Using --aot and *then* --aot -O=all ensures we still get aot even
#    if -o=all causes a compilation failure (which it does on 3-4 of the 
#    core librareies)
RUN for i in /usr/lib/mono/*/mscorlib.dll; do mono --aot $i; done && \
 for i in /usr/lib/mono/*/mscorlib.dll; do mono --aot -O=all $i; done && \
 for i in /usr/lib/mono/gac/*/*/*.dll; do mono --aot $i; done && \
 for i in /usr/lib/mono/gac/*/*/*.dll; do mono --aot -O=all $i; done && \
 mono --aot -O=all /opt/NzbDrone/NzbDrone.exe && \
 for i in /opt/NzbDrone/*.dll; do mono --aot $i; done

RUN mkdir /sonarr && \
 chown -R $MEDIA_USER:$MEDIA_GROUP /sonarr /opt/NzbDrone

ADD start.sh /start.sh

WORKDIR /opt/NzbDrone

VOLUME ["/sonarr"]
EXPOSE 8989

CMD ["/start.sh"]
