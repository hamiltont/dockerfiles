#! /bin/sh

set -e

# On restart bring CP up to master
su -c "cd /couchpotato && git pull" - $MEDIA_USER

sed -i "s|MEDIA_USER|${MEDIA_USER}|g" /etc/supervisor/conf.d/couchpotato.conf 

echo "Starting supervisord"
# Run CP under supervisor just to avoid restarting the container on CP update
exec /usr/bin/supervisord --configuration /etc/supervisor/conf.d/couchpotato.conf
