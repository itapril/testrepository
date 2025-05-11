FROM bitnami/apisix:3.12.0
EXPOSE 9080 9443

COPY ./docker-entrypoint.sh /usr/local/apisix/docker-entrypoint.sh
# RUN chmod g+rwX /docker-entrypoint.sh
# CMD ["/bin/bash", "/docker-entrypoint.sh"]
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/usr/local/apisix/docker-entrypoint.sh"]

STOPSIGNAL SIGQUIT
