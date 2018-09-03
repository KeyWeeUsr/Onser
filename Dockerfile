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

# fix NGINX permission errors when running as non-root
RUN mkdir -p /var/lib/nginx/body && \
    mkdir -p /var/lib/nginx/proxy && \
    mkdir -p /var/lib/nginx/fastcgi && \
    mkdir -p /var/lib/nginx/uwsgi && \
    mkdir -p /var/lib/nginx/scgi

# create volume for web content
VOLUME ['/home/onser/www']

# copy custom NGINX config
COPY nginx.conf /home/onser/nginx.conf

# copy available web content into container
COPY www/* /home/onser/www/

# configure Tor to run .onion service
RUN echo 'HiddenServiceDir /home/onser/www' >> /etc/tor/torrc && \
    echo 'HiddenServiceVersion 3' >> /etc/tor/torrc && \
    echo 'HiddenServicePort 80 127.0.0.1:6666' >> /etc/tor/torrc

# chown mouted folder for user
# fix too permissive permissions before running the service
RUN chown -R onser:onser /home/onser/www && \
    chmod -R 0644 /home/onser/www && \
    chmod 0700 /home/onser/www

# start NGINX at the user home location
ENTRYPOINT \
    nginx -t -c /home/onser/nginx.conf && \
    nginx -c /home/onser/nginx.conf -p /home/onser && \
    tor
USER onser
