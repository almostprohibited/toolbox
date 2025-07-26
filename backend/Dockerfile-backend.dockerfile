FROM arm64v8/alpine:latest AS backend
ARG API_BINARY_NAME
ARG INDEXER_BINARY_NAME
LABEL org.opencontainers.image.source=https://github.com/almostprohibited/backend
RUN test -n "$API_BINARY_NAME" || (echo "Missing --build-arg API_BINARY_NAME" && false) && \
	test -n "$INDEXER_BINARY_NAME" || (echo "Missing --build-arg INDEXER_BINARY_NAME" && false)
COPY $API_BINARY_NAME /bin/almostprohibited-api
RUN chmod +x /bin/almostprohibited-api

FROM backend AS release
COPY $INDEXER_BINARY_NAME /bin/almostprohibited-indexer
# Alpine defaults to UTC, 7am UTC is 12am PST
# TODO: move entrypoint script into a script in repo, not in Dockerfile
RUN chmod +x /bin/almostprohibited-indexer && \
	echo "10 7 * * * /bin/almostprohibited-indexer" >> /var/spool/cron/crontabs/root && \
	echo "#!/bin/sh" >> /usr/local/bin/entrypoint.sh && \
	echo "crond -b" >> /usr/local/bin/entrypoint.sh && \
	echo "exec \"\$@\"" >> /usr/local/bin/entrypoint.sh && \
	chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/almostprohibited-api"]

FROM backend
CMD ["/bin/almostprohibited-api"]
