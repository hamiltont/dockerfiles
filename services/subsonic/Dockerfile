FROM hamiltont/media

RUN apt-get update && \
 apt-get install -y wget \
  ffmpeg flac lame \
  openjdk-7-jre-headless && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/*
 
RUN wget -O /tmp/subsonic.deb http://downloads.sourceforge.net/project/subsonic/subsonic/5.2.1/subsonic-5.2.1.deb && \ 
 dpkg -i /tmp/subsonic.deb && \
 rm -f /tmp/subsonic.deb && \
 sed -i "s| > \${LOG} 2>&1 &||" /usr/share/subsonic/subsonic.sh && \
 mkdir -p /subsonic /var/music /var/playlists && \
 chown -R $MEDIA_USER:$MEDIA_GROUP /subsonic /usr/share/subsonic /var/music /var/playlists

ADD start.sh /start.sh

VOLUME ["/subsonic"]
EXPOSE 4040

CMD ["/start.sh"]
