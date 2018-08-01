FROM ubuntu:bionic
MAINTAINER Mambix Ltd. <ledi.mambix@gmail.com>

RUN apt-get update && apt-get install -y \
  software-properties-common

RUN add-apt-repository -y ppa:ethereum/ethereum && apt-get update && apt-get install -y \
  geth

EXPOSE 3001 8333 18333

ENTRYPOINT [ "geth" ]
