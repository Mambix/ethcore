FROM ubuntu-apache2-php7:7.2
MAINTAINER Mambix Ltd. <ledi.mambix@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
  echo "tzdata tzdata/Zones/Europe select London" > /tmp/preseed.txt; \
  debconf-set-selections /tmp/preseed.txt && \
  apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:ethereum/ethereum && \
  apt-get update && \
  apt-get install -y geth

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

ENTRYPOINT [ "geth" ]
