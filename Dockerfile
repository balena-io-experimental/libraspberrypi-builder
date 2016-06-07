FROM ubuntu:14.04

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
		lib32stdc++6 \
		lib32z1 \
		gcc-multilib \
		g++-multilib \
		dpkg-dev --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get -y autoremove

ENV PGK_DIR raspberrypi-firmware-nokernel-1.20150212

RUN git clone https://github.com/resin-io-playground/userland.git \
	&& curl -SLO https://github.com/raspberrypi/tools/archive/648a6eeb1e3c2b40af4eb34d88941ee0edeb3e9a.tar.gz \
	&& echo "ad15e96337cef84defc27cf99f110e1ea64f4fa7bf51538a9feb8a178b8f4e69  648a6eeb1e3c2b40af4eb34d88941ee0edeb3e9a.tar.gz" | sha256sum -c - \
	&& mkdir /tools \
	&& tar -xzf 648a6eeb1e3c2b40af4eb34d88941ee0edeb3e9a.tar.gz -C /tools --strip-components=1 \
	&& rm -rf 648a6eeb1e3c2b40af4eb34d88941ee0edeb3e9a.tar.gz

RUN echo "deb-src http://archive.raspbian.org/raspbian jessie main contrib non-free rpi firmware" >> /etc/apt/sources.list \
	&& apt-key adv --keyserver pgp.mit.edu  --recv-key 0x9165938D90FDDD2E \
	&& apt-get update && apt-get source libraspberrypi0

ENV PATH $PATH:/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin

COPY build.sh /usr/bin/
CMD ["/usr/bin/build.sh"]
