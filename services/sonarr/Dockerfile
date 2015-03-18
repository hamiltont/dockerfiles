FROM hamiltont/media
MAINTAINER Hamilton Turner <hamiltont@gmail.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install latest mono
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
# echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list && \
# apt-get update && \
# apt-get install -y mono-devel && \
# apt-get clean && \
# rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install sonarr
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
 echo "deb http://apt.sonarr.tv/ develop main" > /etc/apt/sources.list.d/sonarr.list && \
 apt-get update && \
 apt-get install -y nzbdrone mediainfo && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Replace sonarr's mono with upgraded version
ADD build-mono.sh /build-mono.sh
RUN chmod a+x /build-mono.sh && \
 . /build-mono.sh mono-3.6.0.39

# Run Ahead-of-time compilation on all DLLs and EXEs
#   See http://www.mono-project.com/docs/advanced/aot/
#   Note: Avoid using -O=all with *.dlls inside /opt/NzbDrone, can cause segfaults
#   Using --aot and *then* --aot -O=all ensures we still get aot even
#    if -o=all causes a compilation failure (which it does on 3-4 of the 
#    core librareies)
#   Update: Avoiding -O=all everywhere, it's unpredictable and causes failures
#RUN for i in /usr/lib/mono/*/mscorlib.dll; do mono --aot $i; done && \
# for i in /usr/lib/mono/gac/*/*/*.dll; do mono --aot $i; done && \
# mono --aot /opt/NzbDrone/NzbDrone.exe && \
# for i in /opt/NzbDrone/*.dll; do mono --aot $i; done

# Install supervisor (auto-restart on both updates and mono crashes)
RUN apt-get update && \
 apt-get install -y supervisor && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /sonarr && \
 chown -R $MEDIA_USER:$MEDIA_GROUP /sonarr /opt/NzbDrone

ADD start.sh /start.sh
ADD supervisord.conf /etc/supervisor/conf.d/sonarr.conf

WORKDIR /opt/NzbDrone

VOLUME ["/sonarr"]
EXPOSE 8989

CMD ["/start.sh"]
