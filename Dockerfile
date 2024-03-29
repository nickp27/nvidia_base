ARG NVIDIA_DRIVER_VERSION=460.56

FROM ubuntu:20.04

MAINTAINER nickp27

WORKDIR /
ENV DEBIAN_FRONTEND=noninteractive
ENV BUILD_PACKAGES curl git kmod build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev
ENV DRIVER_ARCHIVE=NVIDIA-Linux-x86_64-460.56
ENV SITE=download.nvidia.com/XFree86/Linux-x86_64

RUN apt-get update 
RUN apt-get install -y $BUILD_PACKAGES

RUN curl -v -L http://${SITE}/460.56/${DRIVER_ARCHIVE}.run -o /tmp/${DRIVER_ARCHIVE}.run
RUN sh /tmp/NVIDIA-Linux-x86_64-*run -s -N --no-kernel-module 
RUN rm -rf /tmp/*.run

RUN apt-get clean
RUN apt-get remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) 
RUN rm -rf /var/lib/apt/lists/*

