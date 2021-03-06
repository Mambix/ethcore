FROM ubuntu:bionic
MAINTAINER Mambix Ltd. <ledi.mambix@gmail.com>

RUN apt-get update && \
  apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:ethereum/ethereum && \
  apt-get update && \
  apt-get install -y geth

COPY ./run.sh /
RUN chmod +x /run.sh

EXPOSE 8545 30303

ENTRYPOINT [ "/run.sh" ]
