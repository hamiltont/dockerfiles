#! /bin/sh
set -e

exec su -c "/usr/share/subsonic/subsonic.sh --home=/subsonic --max-memory=300" - $MEDIA_USER
