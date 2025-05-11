FROM bitnami/apisix:3.12.0
EXPOSE 9080 9443

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
# RUN chmod +x /docker-entrypoint.sh
# CMD ["/bin/bash", "/docker-entrypoint.sh"]
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/docker-entrypoint.sh"]

STOPSIGNAL SIGQUIT
