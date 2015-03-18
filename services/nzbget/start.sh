#! /bin/sh

set -e

[ ! -f /nzbget/nzbget.conf ] && cp /usr/local/share/nzbget/nzbget.conf /nzbget/nzbget.conf

# Tried using `--option DaemonUsername=$MEDIA_USER` but it seems to be ignored
# TODO - Once docker exec supports --user, change the Dockerfile to say USER
# instead of using su to drop root. If someone somehow gets a console out of 
# nzbget, I'd rather they not just say 'logout' and arrive at the root user ;)
exec su -c "nzbget --configfile /nzbget/nzbget.conf --daemon" - $MEDIA_USER
