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
COPY static/ /usr/lib/python2.7/site-packages/datagrepper/static/
RUN cd /var/tmp && \
    git clone https://github.com/release-engineering/fedmsg_meta_umb && \
    cd fedmsg_meta_umb && \
    python setup.py install
# Install the latest moksha.hub, just to test it.
RUN yum -y install https://kojipkgs.fedoraproject.org//packages/python-moksha-hub/1.5.2/1.el7/noarch/python-moksha-hub-1.5.2-1.el7.noarch.rpm
USER 1001
