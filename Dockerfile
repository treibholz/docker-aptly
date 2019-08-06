FROM debian:buster-slim
ENV LANG=C.UTF-8

LABEL maintainer="lukas.steiner@steinheilig.de"
LABEL repository="github.com/lu1as/docker-aptly"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gnupg1 aptly moreutils xz-utils zstd bzip2 procps \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -u 1000 -m -d /aptly -s /bin/bash aptly 

COPY entrypoint.sh /entrypoint.sh
COPY add_incoming.sh /add_incoming.sh

USER aptly
WORKDIR /aptly
VOLUME /aptly
VOLUME /incoming

CMD [ "/entrypoint.sh" ]
