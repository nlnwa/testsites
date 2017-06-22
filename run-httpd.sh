#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

if [ -z "${HOST}" ]; then
    IP=$(hostname -I)
else
    P=$(ping -c1 -w10 -n ${HOST})
    if [ $? -eq 0 ]; then
	IP=$(echo ${P} | sed "s/[^(]*(\([^)]*\).*/\1/")
    else
	echo "Could not resolve host '${HOST}'"
	exit 1
    fi
fi

sed -i "s/mylocalip/${IP}/g" /etc/dnsmasq.conf

echo "DNS of testsites resolves all requests to '${IP}'"

/usr/sbin/dnsmasq
exec /usr/sbin/apachectl -DFOREGROUND
