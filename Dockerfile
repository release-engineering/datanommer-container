FROM fedora:31
LABEL \
    name="datanommer" \
    vendor="Factory 2.0" \
    license="GPLv3"
CMD ["fedmsg-hub-3"]
COPY repos/ /etc/yum.repos.d/
RUN dnf -y install \
        python3-fedmsg \
        python3-datanommer-consumer datanommer-commands \
        python3-fedmsg-meta-umb \
        python3-psycopg2 \
        postgresql && \
    dnf -y clean all
RUN rm -f /etc/fedmsg.d/*
COPY fedmsg.d/ /etc/fedmsg.d/
USER 1001
