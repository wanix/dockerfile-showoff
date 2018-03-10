#FROM debian:jessie
FROM alpine:3.7
MAINTAINER Erwan SEITE <wanix(dot)fr(at)gmail(dot)com>
ENV SHOWOFF_VERSION 0.19.6
RUN apk add --update --no-cache \
    ruby ruby-dev ruby-irb ruby-libs \
    ghostscript-fonts musl qt5-qtbase-x11 qt5-qtsvg qt5-qtwebkit \
    libxml2 libxml2-dev libxslt libxslt-dev librsvg \
    make patch gcc g++ zlib-dev \
    xvfb dbus mesa-dri-swrast \
  && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.5/main' > /etc/apk/repositories \
  && apk add --no-cache imagemagick=6.9.6.8-r1 imagemagick-dev=6.9.6.8-r1 \
  && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.7/main' > /etc/apk/repositories \
  && apk add wkhtmltopdf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache \
  && gem install --no-ri --no-rdoc rmagick pdfkit \
  && gem install --no-ri --no-rdoc nokogiri -- --use-system-libraries \
  && gem install --no-ri --no-rdoc showoff -v $SHOWOFF_VERSION \
  && apk del ruby-dev libxml2-dev libxslt-dev make patch gcc g++ zlib-dev imagemagick-dev && \
  rm -rf /var/cache/apk/*

RUN mkdir -p /srv/showoff && mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf.ori \
    && echo $'#!/bin/sh\nXvfb :0 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset & \nDISPLAY=:0.0 /usr/bin/wkhtmltopdf.ori $@\nkillall Xvfb' > /usr/bin/wkhtmltopdf.xvfb-wrapper \
    && chmod a+rx /usr/bin/wkhtmltopdf.xvfb-wrapper \
    && cd /usr/bin && ln -s wkhtmltopdf.xvfb-wrapper wkhtmltopdf

COPY example/showoff.json /srv/showoff/showoff.json
COPY example/testing.md /srv/showoff/testing.md

WORKDIR /srv/showoff

VOLUME ["/srv/showoff"]

EXPOSE 9090

CMD ["showoff", "serve"]
