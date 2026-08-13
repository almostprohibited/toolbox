FROM ubuntu:26.04

LABEL org.opencontainers.image.source=https://github.com/almostprohibited/backend

RUN apt update && apt install -y ca-certificates && rm -rf /var/lib/apt/lists/*

ARG API_BINARY_NAME
RUN test -n "$API_BINARY_NAME" || (echo "Missing --build-arg API_BINARY_NAME" && false)

COPY $API_BINARY_NAME /bin/almostprohibited-api
RUN chmod +x /bin/almostprohibited-api

CMD ["/bin/almostprohibited-api"]
