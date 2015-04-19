#!/bin/bash
# chkconfig: 345 91 10
# description: mule Start Stop Restart
# processname: mule

#
# Copy this script to /etc/init.d
# Run: chmod 755 /etc/init.d/mule
# Run: chkconfig --add mule
#

MULE_HOME=/opt/mule
case $1 in
start)
sh $MULE_HOME/bin/mule start
;;
stop)
sh $MULE_HOME/bin/mule stop
;;
restart)
sh $MULE_HOME/bin/mule restart
;;
esac
exit 0