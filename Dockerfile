FROM registry.fedoraproject.org/fedora:33

ENV DATANOMMER_VERSION="0.2.0"
ENV FEDMSG_META_UMB_VERSION="0.0.4"

LABEL name="datanommer" \
      version="$DATANOMMER_VERSION" \
      vendor="Red Hat EXD Software Production" \
      license="GPL-3.0-or-later" \
      org.opencontainers.image.title="datanommer" \
      org.opencontainers.image.version="$DATANOMMER_VERSION" \
      org.opencontainers.image.description="datanommer in a container, suitable for running on OpenShift" \
      org.opencontainers.image.vendor="Red Hat EXD Software Production" \
      org.opencontainers.image.authors="EXD Messaging Guild <exd-guild-messaging@redhat.com>" \
      org.opencontainers.image.licenses="GPL-3.0-or-later" \
      org.opencontainers.image.url="https://github.com/release-engineering/datanommer-container" \
      org.opencontainers.image.source="https://github.com/release-engineering/datanommer-container" \
      org.opencontainers.image.documentation="https://github.com/fedora-infra/datanommer" \
      distribution-scope="public"

CMD ["fedmsg-hub-3"]
COPY repos/ /etc/yum.repos.d/

ENV DNF_CMD="dnf -y --setopt=install_weak_deps=0"
RUN $DNF_CMD install \
        python3-fedmsg \
        python3-datanommer-consumer datanommer-commands \
        python3-fedmsg-meta-umb \
        python3-psycopg2 \
        postgresql && \
    $DNF_CMD clean all
RUN rm -f /etc/fedmsg.d/*
COPY fedmsg.d/ /etc/fedmsg.d/

USER 1001
