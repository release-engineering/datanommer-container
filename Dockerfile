FROM centos:7
LABEL \
    name="datanommer instance for the Unified Message Bus (UMB)" \
    vendor="Factory 2.0" \
    license="GPLv3"
CMD ["fedmsg-hub"]
RUN yum -y install epel-release && yum -y clean all
RUN yum -y --enablerepo=epel-testing install \
        fedmsg-hub \
        python-datanommer-consumer datanommer-commands \
        python-psycopg2 \
        postgresql \
        git && \
    yum -y clean all
COPY fedmsg.d/ /etc/fedmsg.d/
RUN cd /var/tmp && \
    git clone https://github.com/release-engineering/fedmsg_meta_umb && \
    cd fedmsg_meta_umb && \
    python setup.py install
# Build-time dependencies of fedmsg, only required if installing from git
RUN yum -y install gcc libffi-devel openssl-devel python-devel && \
    yum -y clean all
# Temporarily install fedmsg from git to try some stuff out
RUN cd /var/tmp && \
    git clone https://github.com/fedora-infra/fedmsg && \
    cd fedmsg && \
    git checkout develop && \
    python setup.py install
USER 1001
