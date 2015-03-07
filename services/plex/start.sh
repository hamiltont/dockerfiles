#!/bin/sh

# Print out main setup variables

# Enable command tracing
set -x

env | sort | grep PLEX

ulimit -s $PLEX_MEDIA_SERVER_MAX_STACK_SIZE
ulimit -n $PLEX_MEDIA_SERVER_MAX_OPEN_FILES

PREF="$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Preferences.xml"
if [ ! -f "$PREF" ]
then
  echo "Preferences file does not exist, creating"
  
  # Start PMS so it auto-creates the files
  cd $PLEX_MEDIA_SERVER_HOME
  timeout 10s ./Plex\ Media\ Server
  
  # Edit the preferences file to allow unauthenticated access from host network
  # This allows http://<hostip>:<docker-nat-of-plex-32400> to actually see the 
  # server instead of just having access to the web interface
  sed -i "s|/>| allowedNetworks=\"${PLEX_HOSTNET}\" />|g" "$PREF"

  # Ensure the correct user owns all the files plex just created
  chown -R $MEDIA_USER:$MEDIA_GROUP $PLEX_MEDIA_SERVER_HOME $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR

  echo "Updated preferences"
  cat "$PREF"
else
  echo "Preferences:"
  cat "$PREF"
  echo "Ensure that preferences contains allowedNetworks=\"${PLEX_HOSTNET}\""
fi

rm -f "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/plexmediaserver.pid"

# Avahi and dbus keep PID files in here
rm -rf /var/run/*

# Ensure dbus is ready to roll
mkdir -p /var/run/dbus
chown messagebus:messagebus /var/run/dbus

# Overcome limits of environment variable usage inside supervisord
# Note: These limits will be removed in supervisor 3.2
sed -i "s|MEDIA_USER|${PLEX_MEDIA_SERVER_USER}|g" /etc/supervisor/conf.d/plex.conf 

exec /usr/bin/supervisord --configuration /etc/supervisor/conf.d/plex.conf
