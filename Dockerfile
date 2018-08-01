FROM ubuntu:bionic
MAINTAINER Mambix Ltd. <ledi.mambix@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
  echo "tzdata tzdata/Zones/Europe select London" > /tmp/preseed.txt; \
  debconf-set-selections /tmp/preseed.txt && \
  apt-get update && apt-get install -y \
  software-properties-common \
  tzdata && \
  add-apt-repository -y ppa:ethereum/ethereum && apt-get update && apt-get install -y \
  geth \
  apache2 \
  libapache2-mod-php

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV APACHE_RUN_USER    www-data
ENV APACHE_RUN_GROUP   www-data
ENV APACHE_PID_FILE    /var/run/apache2.pid
ENV APACHE_RUN_DIR     /var/run/apache2
ENV APACHE_LOCK_DIR    /var/lock/apache2
ENV APACHE_LOG_DIR     /var/log/apache2
ENV LANG               C

CMD ["/etc/init.d/apache2", "start"]

EXPOSE 80

ENTRYPOINT [ "geth" ]
