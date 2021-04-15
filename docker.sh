#!/bin/bash

docker build -t sigidoc .
docker run -it -p 9000:9999 --rm --name sigidoc sigidocs
