FROM ubuntu:bionic
MAINTAINER Mambix Ltd. <ledi.mambix@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
  echo "tzdata tzdata/Zones/Europe select London" > /tmp/preseed.txt; \
  debconf-set-selections /tmp/preseed.txt && \
  apt-get update && apt-get install -y \
  software-properties-common \
  tzdata

RUN add-apt-repository -y ppa:ethereum/ethereum && apt-get update && apt-get install -y \
  geth \
  apache2 \
  libapache2-mod-php

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

ENTRYPOINT [ "geth" ]
