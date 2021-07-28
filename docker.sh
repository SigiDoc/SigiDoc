#!/bin/bash

docker build -t sigidoc .
docker run -it -p 9999:9999 --rm --name sigidoc sigidoc
