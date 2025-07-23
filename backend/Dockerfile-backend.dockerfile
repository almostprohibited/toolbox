FROM arm64v8/alpine:latest

LABEL org.opencontainers.image.source=https://github.com/almostprohibited/backend

ARG API_BINARY_NAME
RUN test -n "$API_BINARY_NAME" || (echo "Missing --build-arg API_BINARY_NAME" && false)

ARG INDEXER_BINARY_NAME
RUN test -n "$INDEXER_BINARY_NAME" || (echo "Missing --build-arg INDEXER_BINARY_NAME" && false)

ARG API_BINARY_NAME
COPY $API_BINARY_NAME /bin/almostprohibited-api

ARG INDEXER_BINARY_NAME
COPY $INDEXER_BINARY_NAME /bin/almostprohibited-indexer

RUN chmod +x /bin/almostprohibited-api && \
	chmod +x /bin/almostprohibited-indexer

CMD ["/bin/almostprohibited-api"]
