FROM debian:9.5-slim

RUN useradd --create-home --shell /bin/sh onser
WORKDIR /home/onser
