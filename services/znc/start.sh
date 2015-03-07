#! /bin/sh

set -e

[ ! -f /zncdata/configs/znc.conf ] && cp /znc.conf.default /zncdata/configs/znc.conf

su -c "znc --foreground --datadir /zncdata" - $MEDIA_USER
