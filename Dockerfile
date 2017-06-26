FROM centos:7
LABEL \
    name="datanommer instance for the Unified Message Bus (UMB)" \
    vendor="Factory 2.0" \
    license="GPLv3"
ENTRYPOINT fedmsg-hub
EXPOSE 8080
RUN yum -y install python-gunicorn && yum -y clean all
RUN yum -y install epel-release && yum -y clean all
RUN yum -y --enablerepo=epel-testing install \
        datagrepper \
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
USER 1001
