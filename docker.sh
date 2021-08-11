#!/bin/bash

docker build -t sigidoc .
docker run -it -p 9999:80 --rm --name sigidoc sigidoc
