FROM ubuntu:xenial

MAINTAINER A. Gökay Duman <smyrnof@gmail.com>

RUN apt-get update -y \
    && apt-get install -y apt-utils \
    && apt install -y curl \
    && curl -L https://packagecloud.io/varnishcache/varnish5/gpgkey | apt-key add - \
    && apt-get install -y debian-archive-keyring \
    && mkdir -p /etc/apt/sources.list.d \
    && echo "deb-src https://packagecloud.io/varnishcache/varnish5/ubuntu/ xenial  main" /etc/apt/sources.list.d/varnishcache_varnish5.list \
    && echo "deb https://packagecloud.io/varnishcache/varnish5/ubuntu/ xenial main" /etc/apt/sources.list.d/varnishcache_varnish5.list \
    && apt-get update -y \
    && apt-get install -y varnish

ADD start.sh /start.sh

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=86400 -p default_grace=86400

EXPOSE 80

ENTRYPOINT ./start.sh
