FROM ubuntu:26.04

LABEL org.opencontainers.image.source=https://github.com/almostprohibited/backend

RUN apt update && apt install -y ca-certificates cron && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

ARG INDEXER_BINARY_NAME
RUN test -n "$INDEXER_BINARY_NAME" || (echo "Missing --build-arg INDEXER_BINARY_NAME" && false)

COPY $INDEXER_BINARY_NAME /bin/almostprohibited-indexer
RUN chmod +x /bin/almostprohibited-indexer

COPY indexer-crontab /etc/cron.d/indexer-crontab
RUN chmod 644 /etc/cron.d/indexer-crontab

ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["cron", "-f"]
