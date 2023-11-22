FROM ubuntu:22.04

RUN apt-get update \ 
    && apt-get install --no-install-recommends -y \
        libjson-perl libyaml-perl \
        make zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
