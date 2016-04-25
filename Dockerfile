FROM debian:jessie
MAINTAINER Erwan SEITE <wanix(dot)fr(at)gmail.com>

ENV DEBIAN_RELEASE jessie
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

#Forcing locale first
RUN apt-get update && apt-get install -y --force-yes locales && locale-gen C.UTF-8

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
  locales \
  ruby \
  ruby-dev \
  rubygems-integration \
  ruby-rmagick \
  libxml2 \
  make \
  patch \
  gcc \
  g++ \
  zlib1g-dev \
  wkhtmltopdf \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/* \
  && rm -rf /var/log/apt/*

RUN mkdir /srv/showoff && gem install showoff

COPY example/showoff.json /srv/showoff/showoff.json
COPY example/testing.md /srv/showoff/testing.md

WORKDIR /srv/showoff

VOLUME ["/srv/showoff"]

EXPOSE 9090

CMD ["showoff", "serve"]
