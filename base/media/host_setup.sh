#!/bin/bash

export MEDIA_USER=media
export MEDIA_UID=5000
export MEDIA_GROUP=$MEDIA_USER
export MEDIA_GID=5000

groupadd --gid $MEDIA_GID $MEDIA_GROUP
adduser --disabled-password --uid $MEDIA_UID --gid $MEDIA_GID --gecos '' $MEDIA_USER
