FROM ubuntu:18.04

MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>

WORKDIR ~

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y wget

ENTRYPOINT ["/usr/bin/wget"]
CMD ["https://cdn.wp.nginx.com/wp-content/uploads/2016/07/docker-swarm-hero2.png"]
