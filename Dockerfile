FROM alpine:3.10.1

ENV VEGETA_VERSION 12.8.4

LABEL \
  maintainer="Chandan Pasunoori <chandanpasunoori@gmail.com>" \
  org.opencontainers.image.title="vegeta" \
  org.opencontainers.image.description="Docker image for the Vegeta HTTP load testing tool." \
  org.opencontainers.image.authors="Chandan Pasunoori <chandanpasunoori@gmail.com" \
  org.opencontainers.image.url="https://github.com/chandanpasunoori/vegeta-docker" \
  org.opencontainers.image.vendor="https://www.chandanpasunoori.com" \
  org.opencontainers.image.licenses="MIT" \
  app.tag="vegeta$VEGETA_VERSION"

RUN set -ex \
 && apk add --no-cache ca-certificates jq \
 && apk add --update \
    python \
    py-pip \
    py-cffi \
    py-cryptography \
 && pip install --upgrade pip \
 && apk add --no-cache --virtual .build-deps \
    openssl \
    gcc \
    libffi-dev \
    python-dev \
    linux-headers \
    musl-dev \
    openssl-dev \    
 && pip install gsutil \
 && wget -q "https://github.com/tsenart/vegeta/releases/download/v${VEGETA_VERSION}/vegeta_${VEGETA_VERSION}_linux_amd64.tar.gz" -O /tmp/vegeta.tar.gz \
 && cd bin \
 && tar xzf /tmp/vegeta.tar.gz \
 && rm /tmp/vegeta.tar.gz \
 && apk del .build-deps
 && rm -rf /var/cache/apk/*

CMD [ "/bin/vegeta", "-help" ]
