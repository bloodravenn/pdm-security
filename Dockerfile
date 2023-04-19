FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

RUN useradd -d /pdm-security -U pdm-security

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
       htmldoc libxml-writer-perl libarchive-zip-perl libjson-perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /pdm-security

USER pdm-security

WORKDIR /pdm-security

ENTRYPOINT ["/pdm-security/lynis-report-converter.pl"]
CMD ["--help"]
