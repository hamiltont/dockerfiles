FROM hamiltont/media

RUN sed -i 's|wheezy main|wheezy main contrib non-free|g' /etc/apt/sources.list && \
 apt-get update && \
 apt-get install -y git-core python2.7 unrar supervisor && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/*

ADD start.sh /start.sh
ADD supervisord.conf /etc/supervisor/conf.d/couchpotato.conf
RUN git clone https://github.com/RuudBurger/CouchPotatoServer.git /couchpotato && \
 mkdir /couchdata && \
 mkdir -p /var/log/supervisor && \
 chown -R $MEDIA_USER:$MEDIA_GROUP /couchpotato /start.sh /couchdata

VOLUME ["/couchdata"]
EXPOSE 5050

CMD ["/start.sh"]
