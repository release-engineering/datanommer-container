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
# Build-time dependencies of fedmsg_meta_umb, only required if installing from git
RUN yum -y install gcc libffi-devel openssl-devel python-devel && \
    yum -y clean all
RUN cd /var/tmp && \
    git clone https://github.com/release-engineering/fedmsg_meta_umb && \
    cd fedmsg_meta_umb && \
    git checkout ef3d46a && \
    python setup.py install
USER 1001
