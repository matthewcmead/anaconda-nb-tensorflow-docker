FROM matthewcmead/anaconda-nb-docker-centos7 as builder


env TENSORFLOW_VERSION=1.4.0rc1 \
    TENSORBOARD_VERSION=0.4.0rc1

COPY pips /tmp/pips

RUN touch /tmp/timestamp.pip \
&&  pip install --no-cache-dir --no-index --find-links /tmp/pips \
    tensorflow==${TENSORFLOW_VERSION} \
    tensorflow-tensorboard==${TENSORBOARD_VERSION} \
&&  cd /opt/conda && find . -type f -newer /tmp/timestamp.pip >/tmp/conda_changed.txt \
&&  mkdir /tmp/conda_changed \
&&  tar -C /opt/conda -T /tmp/conda_changed.txt -cf - | tar -C /tmp/conda_changed -xf -

FROM matthewcmead/anaconda-nb-docker-centos7 as runner

MAINTAINER matt@matthewcmead.com

COPY --from=builder /tmp/conda_changed /opt/conda
