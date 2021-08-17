#!/bin/bash

docker build -t sigidoc .
docker run -it -p 9999:3000 --rm --name sigidoc sigidoc
