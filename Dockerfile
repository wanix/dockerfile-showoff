#FROM debian:jessie
FROM gliderlabs/alpine:3.3
MAINTAINER Erwan SEITE <wanix(dot)fr(at)gmail(dot)com>

RUN apk add --update --no-cache \
    ruby ruby-dev ruby-rdoc ruby-irb ruby-libs \
    ghostscript-fonts imagemagick imagemagick-dev musl \
    libxml2 libxml2-dev libxslt libxslt-dev librsvg \
    make patch gcc g++ \
    zlib-dev \
    xvfb dbus mesa-dri-swrast \
  && apk add wkhtmltopdf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
RUN gem install rmagick pdfkit && gem install nokogiri -- --use-system-libraries && gem install showoff

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
