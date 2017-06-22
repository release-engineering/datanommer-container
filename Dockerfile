FROM centos:7
LABEL \
    name="datanommer instance for the Unified Message Bus (UMB)" \
    vendor="Factory 2.0" \
    license="GPLv3"
RUN yum -y install epel-release && yum -y clean all
RUN yum -y --enablerepo=epel-testing install \
        fedmsg-hub \
        python-datanommer-consumer datanommer-commands \
        datagrepper \
        python-psycopg2 \
        git && \
    yum -y clean all
RUN cd /var/tmp && \
    git clone https://github.com/release-engineering/fedmsg_meta_umb && \
    cd fedmsg_meta_umb && \
    python setup.py install
COPY fedmsg.d/ /etc/fedmsg.d/
USER 1001
ENTRYPOINT fedmsg-hub
