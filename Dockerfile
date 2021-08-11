FROM openjdk:8

RUN apt update
RUN apt-get -y install apache2

RUN cd /usr/lib/apache2/modules && a2enmod proxy_html
RUN cd /usr/lib/apache2/modules && a2enmod proxy_http

COPY .docker/apache.conf /etc/apache2/sites-available/000-default.conf
RUN unlink /var/www/html/index.html

COPY . /var/www/html/sigidoc
WORKDIR /var/www/html/sigidoc

RUN ["chmod", "+x", "build.sh"]
RUN ["chmod", "+x", "docker-build.sh"]
RUN ["chmod", "+x", "sw/ant/bin/ant"]

CMD ["./docker-build.sh"]
