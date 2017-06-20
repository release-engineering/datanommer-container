FROM fedora:25
LABEL \
    name="datanommer instance for the Unified Message Bus (UMB)" \
    vendor="Factory 2.0" \
    license="GPLv3"
COPY eng-fedora-25-candidate.repo /etc/yum.repos.d/
RUN yum -y install datanommer python-fedmsg-meta-umb && \
    yum -y clean all
COPY fedmsg.d/ /etc/fedmsg.d/
USER 1001
ENTRYPOINT fedmsg-hub
