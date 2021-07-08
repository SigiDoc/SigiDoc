FROM openjdk:15

COPY . /sigidoc
WORKDIR /sigidoc

RUN ["chmod", "+x", "build.sh"]
RUN ["chmod", "+x", "sw/ant/bin/ant"]

CMD ["./build.sh"]
