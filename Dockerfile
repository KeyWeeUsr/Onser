FROM debian:9.5-slim

RUN useradd --create-home --shell /bin/sh onser
WORKDIR /home/onser

RUN apt-get -y update && \
    apt-get -y install apt-transport-https gnupg nginx && \
    apt-get -y purge && \
    apt-get -y autoremove && \
    apt-get -y autoclean
