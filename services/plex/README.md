# docker plex

This is a Dockerfile to set up (https://plex.tv/ "Plex Media Server") - (https://plex.tv/)

---

Everything below assumes you are *not* using --net=host and wish to instead use the 
default of --net=bridge. 

The first time it runs, it will initialize the config directory. To enable remote 
connections (e.g. the ability to log into your server from plex.tv), you need to 
first enable non-authenticated access to the server from your home network. 
To do this, set the `PLEX_HOSTNET` environment variable to be your local network
and netmask, such as `192.168.0.0/255.255.255.0`. On the first startup, this 
will create the correct Plex preferences.xml file to allow nonauthenticated 
connections from this network. 

You then need to use `http://<docker-host>:<NAT of 32400>/web` to log into plex.tv
from the server's settings tab. You may need to log in twice - once to the web 
interface and then once more at the `Settings->Server->Connect` location. It's 
unlikely plex.tv will be able to connect to your server automatically, so you
likely need to enable port-forwarding from your router to `<NAT of 32400>` and 
manually set the external port. 

Once plex.tv has connected to your server successfully, you can then disable 
local network authentication if you so choose. You should bind-mount the 
configuration direction (/plex by default) so that later docker containers 
send the same identification information to plex.tv and it can achieve 
connection by trying all the ports that worked for that server identifier in
the past. 

Note: If you choose to setup a reverse proxy, ensure that you utilize docker's
links to send traffic to `http://<plex-link-alias>:<NAT of 32400>` and *avoid* 
sending traffic to `http://<docker-host>:<NAT of 32400>`, as the latter would
appear to plex to be traffic from inside the `PLEX_HOSTNET` and would therefore
be allowed to view/access media without any authentication. 
