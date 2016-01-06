FROM debian:7.7
MAINTAINER James Bryan Graves <gravesj@purdue.edu>

# Build: docker build -t hubzero .
# Run:   docker run -e 'APACHE_RUN_USER=www-data' -e 'APACHE_RUN_GROUP=www-data' -e 'APACHE_LOG_DIR=/var/log/apache2' -d -p 80:80 --name hubzero hubzero 
# SSH:   docker exec -i -t hubzero bash

# Hubzero setup - JBG
RUN echo "127.0.0.1  example.com  example" >> /etc/hosts; \
  echo "deb http://packages.hubzero.org/deb diego-deb7 main" >> /etc/apt/sources.list; \
  echo "deb http://download.openvz.org/debian wheezy main" >> /etc/apt/sources.list; \
  apt-key adv --keyserver pgp.mit.edu --recv-keys 143C99EF; \
  apt-get update; \
  apt-get install -y wget; \
  wget http://ftp.openvz.org/debian/archive.key -q -O - | apt-key add - \
  apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends install --yes \
      binutils vim mysql-server apache2 hubzero-cms-1.3.0; \
  /etc/init.d/mysql start; \
  hzcms install example; \
  hzcms update; \
  a2ensite example; \
  service apache2 stop

EXPOSE 80
ADD ./run.sh /run.sh
CMD /run.sh

