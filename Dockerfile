FROM debian:9

RUN apt-get update -y
RUN apt-get install -y wget curl
COPY . /build_your_own_distrib
WORKDIR /build_your_own_distrib


