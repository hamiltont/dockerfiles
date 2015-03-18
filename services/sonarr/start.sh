#! /bin/sh

set -e

sed -i "s|MEDIA_USER|${MEDIA_USER}|g" /etc/supervisor/conf.d/sonarr.conf 

echo "Starting supervisord"
exec /usr/bin/supervisord --configuration /etc/supervisor/conf.d/sonarr.conf
