#!/usr/bin/env bash

cd /project/pips
export TENSORFLOW_VERSION=1.4.0rc1
export TENSORBOARD_VERSION=0.4.0rc1
	pip download \
    tensorflow==${TENSORFLOW_VERSION} \
    tensorflow-tensorboard==${TENSORBOARD_VERSION}
