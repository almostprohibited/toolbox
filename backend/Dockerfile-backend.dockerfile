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
RUN chmod +x /bin/almostprohibited-indexer && \
	echo "7 0 * * * /bin/almostprohibited-indexer" >> /var/spool/cron/crontabs/root
CMD ["crond", "-b", "&&", "/bin/almostprohibited-api"]

FROM backend
CMD ["/bin/almostprohibited-api"]
