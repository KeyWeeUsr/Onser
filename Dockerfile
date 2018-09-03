FROM debian:9.5-slim

RUN useradd --create-home --shell /bin/sh onser
WORKDIR /home/onser

RUN apt-get -y update && \
    apt-get -y install apt-transport-https gnupg nginx && \
    echo 'deb https://deb.torproject.org/torproject.org stretch main' \
        >> /etc/apt/sources.list && \
    echo 'deb-src https://deb.torproject.org/torproject.org stretch main' \
        >> /etc/apt/sources.list && \
    gpg --keyserver hkp://pool.sks-keyservers.net \
        --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 && \
    gpg --keyserver hkp://pool.sks-keyservers.net \
        --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - && \
    apt-get -y update && \
    apt-get -y install tor deb.torproject.org-keyring && \
    apt-get -y purge && \
    apt-get -y autoremove && \
    apt-get -y autoclean

# nginx start at the user home location
ENTRYPOINT \
    nginx -p /home/onser && \
    tor
