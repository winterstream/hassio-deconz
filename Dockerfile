FROM arm32v7/debian:jessie-slim

ENV SW_VERSION 2.04.97
ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://archive.raspberrypi.org/debian/ jessie main' > /etc/apt/sources.list.d/raspi.list

RUN apt-key adv --keyserver pgp.mit.edu --recv 82B129927FA3303E

RUN apt-get update

RUN apt-get install -y --no-install-recommends vim curl sudo

RUN curl -O http://www.dresden-elektronik.de/rpi/deconz/beta/deconz-${SW_VERSION}-qt5.deb

RUN dpkg -i deconz-${SW_VERSION}-qt5.deb

RUN rm deconz-${SW_VERSION}-qt5.deb

RUN apt-get install -y -f --no-install-recommends

RUN apt-get remove -y curl

RUN apt-get autoremove -y

RUN rm -rf /var/lib/apt/lists/*

RUN chown root:root /usr/bin/deCONZ*
CMD /usr/bin/deCONZ --auto-connect=1 -platform minimal --http-port=80 --dbg-error=1
