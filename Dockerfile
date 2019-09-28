FROM ubuntu:xenial

MAINTAINER A. Gökay Duman <smyrnof@gmail.com>

RUN apt update
RUN apt install -y curl
RUN curl -L https://packagecloud.io/varnishcache/varnish5/gpgkey | apt-key add -
RUN apt install -y debian-archive-keyring
RUN mkdir -p /etc/apt/sources.list.d
RUN echo "deb-src https://packagecloud.io/varnishcache/varnish5/ubuntu/ xenial  main" /etc/apt/sources.list.d/varnishcache_varnish5.list
RUN echo "deb https://packagecloud.io/varnishcache/varnish5/ubuntu/ xenial main" /etc/apt/sources.list.d/varnishcache_varnish5.list
RUN apt update
RUN apt install varnish

ADD start.sh /start.sh

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=86400 -p default_grace=86400

EXPOSE 80

ENTRYPOINT ./start.sh
