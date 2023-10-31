FROM alpine:3.18.4
MAINTAINER Erwan SEITE <wanix(dot)fr(at)gmail(dot)com>
ENV SHOWOFF_VERSION 0.20.4
RUN apk add --update --no-cache \
    ruby ruby-dev ruby-irb ruby-libs \
    ghostscript-fonts musl libstdc++ \
    make patch gcc g++ zlib-dev \
  && gem install -N pdfkit rexml \
  && gem install -N nokogiri -- --use-system-libraries \
  && gem install -N showoff -v $SHOWOFF_VERSION \
  && apk del --purge binutils libgomp libatomic mpc1 \
     ruby-dev musl-dev musl-dev libc-dev make \
     patch gcc g++ zlib-dev \
  && rm -rf /var/cache/apk/*

COPY example/showoff.json /srv/showoff/showoff.json
COPY example/testing.md /srv/showoff/testing.md

WORKDIR /srv/showoff

VOLUME ["/srv/showoff"]

EXPOSE 9090

CMD ["showoff", "serve"]
