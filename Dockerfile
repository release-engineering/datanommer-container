FROM fedora:25
LABEL \
    name="datanommer instance for the Unified Message Bus (UMB)" \
    vendor="Factory 2.0" \
    license="GPLv3"
COPY eng-fedora-25-candidate.repo /etc/yum.repos.d/
RUN dnf -y --setopt=deltarpm=no update && \
    dnf -y install fedmsg-hub datanommer python-fedmsg-meta-umb python2-psycopg2 && \
    dnf -y clean all
COPY fedmsg.d/ /etc/fedmsg.d/
USER 1001
ENTRYPOINT fedmsg-hub
