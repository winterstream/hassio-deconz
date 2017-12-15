FROM arm32v7/debian:jessie-slim

ENV SW_VERSION 2.04.97
ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://archive.raspberrypi.org/debian/ jessie main' > /etc/apt/sources.list.d/raspi.list && \
	apt-key adv --keyserver pgp.mit.edu --recv 82B129927FA3303E && \
	apt-get update && \
	apt-get install -y --no-install-recommends vim curl sudo && \
	curl -O http://www.dresden-elektronik.de/rpi/deconz/beta/deconz-${SW_VERSION}-qt5.deb && \
	(dpkg -i deconz-${SW_VERSION}-qt5.deb || true) && \
	rm deconz-${SW_VERSION}-qt5.deb && \
	apt-get install -y -f --no-install-recommends && \
	apt-get remove -y curl && \
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/*

RUN chown root:root /usr/bin/deCONZ*
CMD /usr/bin/deCONZ --auto-connect=1 -platform minimal --http-port=80 --dbg-error=1
