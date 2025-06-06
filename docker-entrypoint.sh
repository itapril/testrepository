#!/bin/bash
#/opt/bitnami/apisix/bin/apisix start
if [ -e "/usr/local/apisix/conf/config_listen.sock" ]; then
    rm -f "/usr/local/apisix/conf/config_listen.sock"
fi

if [ -e "/usr/local/apisix/logs/worker_events.sock" ]; then
    rm -f "/usr/local/apisix/logs/worker_events.sock"
fi
if [ -e "/usr/local/apisix/logs/nginx.pid" ]; then
    rm -f "/usr/local/apisix/logs/nginx.pid"
fi

apisix start && tail -f /usr/local/apisix/logs/error.log
