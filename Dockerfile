FROM openjdk:8

# Installing nginx, supervisord, nodejs
RUN apt-get update -yq \
  && apt-get install nginx supervisor -yq

COPY .docker/provisioning/nginx/default /etc/nginx/sites-enabled/default

COPY . /sigidoc
WORKDIR /sigidoc

RUN ["chmod", "+x", "build.sh"]
RUN ["chmod", "+x", "docker-build.sh"]
RUN ["chmod", "+x", "sw/ant/bin/ant"]

CMD ["./docker-build.sh"]
