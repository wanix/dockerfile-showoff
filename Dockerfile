FROM debian:jessie
MAINTAINER Erwan SEITE <wanix(dot)fr@gmail.com>

ENV RELEASE jessie
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
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
  && rm -rf /var/log/apt/* \
  && gem install showoff \
  && mkdir /srv/showoff

COPY example/showoff.json /srv/showoff/showoff.json
COPY example/testing.md /srv/showoff/testing.md

WORKDIR /srv/showoff

VOLUME ["/srv/showoff"]

EXPOSE 9090

CMD ["showoff", "serve"]
