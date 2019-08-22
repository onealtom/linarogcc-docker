FROM ubuntu:16.04

MAINTAINER Oneal Tang <tyf@vavitel.com>

#ADD sources.list /etc/apt/
RUN apt-get update && apt-get install -y \
  build-essential \
  make \
  g++ \
  git \
  wget \
  xz-utils \
  u-boot-tools

# copy in


RUN wget https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabihf/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz -q && \
  mkdir -p /gccroot && \
  tar -xvJf gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz --strip-components 1 -C /gccroot && \
  rm -rf /gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz

#make a user
RUN adduser --disabled-password --gecos '' linaro
USER linaro
WORKDIR /home/linaro

ENV PATH /gccroot/bin:$PATH
ENV ARCH arm
ENV CROSS_COMPILE arm-linux-gnueabihf-

#RUN echo "PATH=$PATH:" >> /home/linaro/.bashrc
#RUN echo "ARCH=arm" >> /home/linaro/.bashrc
#RUN echo "CROSS_COMPILE=arm-linux-gnueabihf-" >> /home/linaro/.bashrc

RUN export
RUN arm-linux-gnueabihf-gcc -v

