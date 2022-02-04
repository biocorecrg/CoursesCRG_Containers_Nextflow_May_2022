FROM biocontainers/fastqc:v0.11.9_cv7

# File Author / Maintainer
MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>

RUN apt-get update; apt-get install -y curl;

# Now adding web stuff
RUN apt-get install -y php-cli

RUN mkdir /wwww
WORKDIR /wwww

COPY index.php .

VOLUME /scratch

# Clean cache
RUN apt-get clean
RUN set -x; rm -rf /var/lib/apt/lists/*

EXPOSE 8083
ENTRYPOINT ["php", "-S", "0.0.0.0:8083"]
