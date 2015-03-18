FROM hamiltont/media
MAINTAINER Hamilton Turner <hamiltont@gmail.com>

RUN sed -i 's|wheezy main|wheezy main contrib non-free|g' /etc/apt/sources.list && \
 apt-get update && \
 apt-get install -y wget build-essential libncurses5-dev libssl-dev libxml2-dev && \
 apt-get install -y par2 pkg-config libsigc++-2.0-dev p7zip unrar && \
 sed -i 's| contrib non-free||g' /etc/apt/sources.list && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/*

ENV VERSION 14.2
RUN wget -O /tmp/nzbget.tar.gz http://downloads.sourceforge.net/project/nzbget/nzbget-stable/$VERSION/nzbget-$VERSION.tar.gz && \
 tar xf /tmp/nzbget.tar.gz && \
 rm /tmp/nzbget.tar.gz && \
 cd /nzbget-$VERSION && \
 ./configure && \
 make && \
 make install && \
 rm -rf /nzbget-$VERSION

ADD start.sh /start.sh

RUN mkdir /nzbget && \
 chown $MEDIA_USER:$MEDIA_GROUP /nzbget

VOLUME ["/nzbget"]
EXPOSE 6789

CMD ["/start.sh"]
