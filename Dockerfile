From ubuntu:latest
MAINTAINER Stylianos Karagiannis <stylianos.karagiannis@pdmfc.com>

RUN apt update && apt install -y git lynis
RUN useradd -d /pdm-security -U lynis

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
       htmldoc libxml-writer-perl libarchive-zip-perl libjson-perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /pdm-security

USER lynis

WORKDIR /pdm-security

ENTRYPOINT ["/pdm-security/lynis-report-converter.pl"]
CMD ["--help"]
