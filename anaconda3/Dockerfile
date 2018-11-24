FROM matthewcmead/anaconda-nb-docker-centos7

MAINTAINER matt@matthewcmead.com

COPY conf/repohost /tmp/repohost

RUN \
    export THEHOST=$(cat /tmp/repohost) \
&&  if grep none /tmp/repohost; then export THEHOST=$(ip route show | grep default | sed "s/^default via //; s/ .*$//"); fi \
&&  /opt/conda/bin/pip install --upgrade --trusted-host ${THEHOST} --no-cache-dir --no-index --find-links http://${THEHOST}:8879/pips/ \
      tensorflow \
      tensorflow-tensorboard \
      expectexception \
      nbzip \
&&  /opt/conda/bin/jupyter serverextension enable --py nbzip --sys-prefix \
&&  /opt/conda/bin/jupyter nbextension install --py nbzip \
&&  /opt/conda/bin/jupyter nbextension enable --py nbzip
