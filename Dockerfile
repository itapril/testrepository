# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0

FROM docker.io/bitnami/minideb:bookworm

ARG DOWNLOADS_URL="downloads.bitnami.com/files/stacksmith"
ARG TARGETARCH

LABEL com.vmware.cp.artifact.flavor="sha256:c50c90cfd9d12b445b011e6ad529f1ad3daea45c26d20b00732fae3cd71f6a83" \
      org.opencontainers.image.base.name="docker.io/bitnami/minideb:bookworm" \
      org.opencontainers.image.created="2025-04-15T00:48:39Z" \
      org.opencontainers.image.description="Application packaged by Broadcom, Inc." \
      org.opencontainers.image.documentation="https://github.com/bitnami/containers/tree/main/bitnami/apisix/README.md" \
      org.opencontainers.image.ref.name="3.12.0-debian-12-r3" \
      org.opencontainers.image.source="https://github.com/bitnami/containers/tree/main/bitnami/apisix" \
      org.opencontainers.image.title="apisix" \
      org.opencontainers.image.vendor="Broadcom, Inc." \
      org.opencontainers.image.version="3.12.0"

ENV HOME="/" \
    OS_ARCH="${TARGETARCH:-amd64}" \
    OS_FLAVOUR="debian-12" \
    OS_NAME="linux"

COPY prebuildfs /
SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]
# RUN chmod +x install_packages && chmod +x run-script
# Install required system packages and dependencies
RUN install_packages ca-certificates curl libcrypt1 libgcc-s1 libpcre3 libstdc++6 libyaml-0-2 procps zlib1g 
RUN mkdir -p /tmp/bitnami/pkg/cache/ ; cd /tmp/bitnami/pkg/cache/ || exit 1 ; \
    COMPONENTS=( \
      "apisix-3.12.0-0-linux-${OS_ARCH}-debian-12" \
    ) ; \
    for COMPONENT in "${COMPONENTS[@]}"; do \
      if [ ! -f "${COMPONENT}.tar.gz" ]; then \
        curl -SsLf "https://${DOWNLOADS_URL}/${COMPONENT}.tar.gz" -O ; \
        curl -SsLf "https://${DOWNLOADS_URL}/${COMPONENT}.tar.gz.sha256" -O ; \
      fi ; \
      sha256sum -c "${COMPONENT}.tar.gz.sha256" ; \
      tar -zxf "${COMPONENT}.tar.gz" -C /opt/bitnami --strip-components=2 --no-same-owner ; \
      rm -rf "${COMPONENT}".tar.gz{,.sha256} ; \
    done
RUN mkdir -p /tmp/bitnami/pkg/cache/ ; cd /tmp/bitnami/pkg/cache/ || exit 1 ; \
    COMPONENTS=( \
      "java-21.0.7-9-0-linux-${OS_ARCH}-debian-12" \
    ) ; \
    for COMPONENT in "${COMPONENTS[@]}"; do \
      if [ ! -f "${COMPONENT}.tar.gz" ]; then \
        curl -SsLf "https://${DOWNLOADS_URL}/${COMPONENT}.tar.gz" -O ; \
        curl -SsLf "https://${DOWNLOADS_URL}/${COMPONENT}.tar.gz.sha256" -O ; \
      fi ; \
      sha256sum -c "${COMPONENT}.tar.gz.sha256" ; \
      tar -zxf "${COMPONENT}.tar.gz" -C /opt/bitnami --strip-components=2 --no-same-owner ; \
      rm -rf "${COMPONENT}".tar.gz{,.sha256} ; \
    done
RUN apt-get update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
# RUN update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX && \ DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
# RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

RUN useradd -r -u 1001 -g root apisix
RUN chmod g+rwX /opt/bitnami/apisix/conf && mkdir -p /usr/local/apisix/logs && chmod -R g+rwX /usr/local/apisix && ln -s /opt/bitnami/apisix/conf /usr/local/apisix && ln -s /opt/bitnami/apisix/deps /usr/local/apisix && ln -s /opt/bitnami/apisix/openresty/luajit/share/lua/*/apisix /usr/local/apisix
# RUN find / -perm /6000 -type f -exec chmod a-s {} \; || true

ENV APP_VERSION="3.12.0" \
    BITNAMI_APP_NAME="apisix" \
    LUA_PATH="/opt/bitnami/apisix/deps/share/lua/5.1/?/init.lua" \
    JAVA_HOME="/opt/bitnami/java" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    PATH="/opt/bitnami/java/bin:/opt/bitnami/apisix/bin:/opt/bitnami/apisix/openresty/bin:/opt/bitnami/apisix/openresty/luajit/bin:/opt/bitnami/apisix/openresty/luarocks/bin:/opt/bitnami/apisix/openresty/nginx/sbin:$PATH"

USER 1001
ENTRYPOINT [ "/opt/bitnami/apisix/bin/apisix" ]
