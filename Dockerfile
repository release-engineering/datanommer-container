FROM registry.fedoraproject.org/fedora-minimal:33

LABEL name="datanommer" \
      vendor="Red Hat EXD Software Production" \
      license="GPL-3.0-or-later" \
      org.opencontainers.image.title="datanommer" \
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

RUN microdnf install \
        python3-fedmsg \
        python3-datanommer-consumer datanommer-commands \
        python3-fedmsg-meta-umb \
        python3-psycopg2 \
        postgresql && \
    dnf -y clean all
RUN rm -f /etc/fedmsg.d/*
COPY fedmsg.d/ /etc/fedmsg.d/

USER 1001
