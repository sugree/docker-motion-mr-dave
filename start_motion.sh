#!/bin/bash

if [ -n "${TIMEZONE}" ]; then
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
fi

if [ -f /data1/config/motion.conf ]; then
  MOTION_OPTS="-c /data1/config/motion.conf"
else
  MOTION_OPTS="-c /usr/local/etc/motion.conf"
fi

exec /usr/local/bin/motion $MOTION_OPTS
