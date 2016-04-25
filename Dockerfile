FROM debian:jessie
MAINTAINER Erwan SEITE <wanix(dot)fr(at)gmail.com>

ENV DEBIAN_RELEASE jessie
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
  ruby \
  ruby-dev \
  ruby-rmagick \
  make \
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
