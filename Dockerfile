FROM ubuntu:bionic
MAINTAINER Mambix Ltd. <ledi.mambix@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
  echo "tzdata tzdata/Zones/Europe select London" > /tmp/preseed.txt; \
  debconf-set-selections /tmp/preseed.txt && \
  apt-get update && \
  apt-get install -y software-properties-common tzdata supervisor apache2 git

RUN add-apt-repository -y ppa:ethereum/ethereum

RUN apt-get update && apt-get install -y --no-install-recommends \
    geth \
    libapache2-mod-php \
    php7.2 \
		# php7.2-bcmath \
		# php7.2-cli \
		# php7.2-curl \
		# php7.2-dev \
		# php7.2-gd \
		# php7.2-imap \
		# php7.2-intl \
		# php7.2-mbstring \
		# php7.2-mysql \
		# php7.2-pgsql \
		# php7.2-pspell \
		# php7.2-xml \
		# php7.2-xmlrpc \
		# php-apcu \
		# php-memcached \
		# php-pear \
		# php-redis \
  && apt-get clean && \
  rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/www/html/*

RUN git clone https://github.com/everexio/ethplorer.git /var/www/html

RUN a2enmod rewrite
COPY conf/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/config.php /var/www/html/config.php

COPY script/run.sh /run.sh
RUN chmod 755 /run.sh

COPY conf/config /config

EXPOSE 80
CMD [ "/run.sh" ]
