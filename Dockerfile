FROM gliderlabs/alpine:3.4
MAINTAINER Erwan SEITE <wanix(dot)fr(at)gmail(dot)com>

RUN apk add --update --no-cache \
    ruby ruby-dev ruby-rdoc ruby-irb ruby-libs \
    ghostscript-fonts musl \
    make patch gcc g++ \
    zlib-dev \
    xvfb dbus mesa-dri-swrast \
  && apk add wkhtmltopdf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
RUN gem install pdfkit --no-ri --no-rdoc && gem install nokogiri --no-ri --no-rdoc && gem install showoff -v 0.13.3 --no-ri --no-rdoc
RUN apk del --purge binutils-libs binutils isl libgomp libatomic mpfr3 mpc1 gcc make musl-dev libc-dev fortify-headers g++ build-base zlib-dev

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
