FROM resin/rpi-raspbian:latest

RUN apt-get update && apt-get install -y \
		build-essential \
		devscripts \
		debhelper \
		fakeroot \
		quilt \
		git-core \
		curl \
		ca-certificates \
		cmake \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get -y autoremove

ENV PGK_DIR raspberrypi-firmware-nokernel

RUN git clone --branch client-id https://github.com/resin-io-playground/userland.git
RUN curl -SL http://archive.raspbian.org/raspbian/pool/firmware/r/raspberrypi-firmware-nokernel/raspberrypi-firmware-nokernel_1.20150212-1~nokernel1.tar.gz -o $PGK_DIR.tar.gz \
	&& mkdir $PGK_DIR
	&& tar -xzf $PGK_DIR.tar.gz -C /$PGK_DIR --strip-components=1

COPY build.sh /usr/bin/
CMD ["/usr/bin/build.sh"]
