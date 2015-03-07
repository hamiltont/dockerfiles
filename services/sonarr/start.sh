#! /bin/sh

set -e

exec su -c "mono /opt/NzbDrone/NzbDrone.exe --no-browser -data=/sonarr" - $MEDIA_USER
