#!/bin/bash
/opt/bitnami/apisix/bin/apisix start
while true; do
    echo "This is a running script"
    sleep 5
done
