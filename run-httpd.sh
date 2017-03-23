#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

cat /etc/dnsmasq.conf | sed "s/mylocalip/$(hostname -I)/g" > /etc/dnsmasq.confs
mv /etc/dnsmasq.confs /etc/dnsmasq.conf
/usr/sbin/dnsmasq
exec /usr/sbin/apachectl -DFOREGROUND
