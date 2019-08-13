FROM centos:7
MAINTAINER Norsk Nettarkiv

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd mod_ssl openssl dnsmasq bind-utils && \
    yum clean all

EXPOSE 80
EXPOSE 53
EXPOSE 443

RUN mkdir -p /var/www/html/test/

ADD dnsmasq.conf /etc/
ADD httpd.conf /etc/httpd/conf/
ADD openssl.cnf /etc/httpd/conf/
ADD apache-icon.gif /var/www/html/test/static.com/
ADD bigpic.png /var/www/html/test/static.com/
ADD create_sites.sh /var/www/html/test/
RUN openssl genrsa -out /etc/httpd/server.key 2048
RUN openssl req -new -batch -key /etc/httpd/server.key -out /etc/httpd/server.csr -config /etc/httpd/conf/openssl.cnf
RUN openssl x509 -req -days 3650 -in /etc/httpd/server.csr -signkey /etc/httpd/server.key -out /etc/httpd/server.crt -extensions v3_req -extfile /etc/httpd/conf/openssl.cnf

# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh && \
    chmod +x /var/www/html/test/create_sites.sh
ENV NUMBER_OF_SITES='2500' \
    DOMAIN_DEPTH='5'

RUN ["/var/www/html/test/create_sites.sh"]
CMD ["/run-httpd.sh"]

