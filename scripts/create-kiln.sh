#!/bin/bash

curl -X POST -v "http://localhost:9999/openrdf-workbench/repositories/NONE/create" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "type=memory-rdfs-dt&Repository+ID=kiln&Repository+title=&Persist=true&Sync+delay=0"
