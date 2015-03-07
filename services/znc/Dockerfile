FROM hamiltont/media

RUN apt-get update && \
 apt-get install -y wget build-essential libperl-dev libssl-dev && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -O /tmp/znc.tgz http://znc.in/releases/znc-1.6.0.tar.gz && \
 tar xvf /tmp/znc.tgz && \
 cd /znc-* && \
 ./configure && \
 make && \
 make install && \
 rm -rf /tmp/znc /znc-* 

ADD znc.conf /znc.conf.default
ADD start.sh /start.sh

RUN mkdir -p /zncdata/configs && \
 chown -R $MEDIA_USER:$MEDIA_GROUP /zncdata /znc.conf.default 

VOLUME ["/zncdata"]
EXPOSE 6667

CMD ["/start.sh"]
