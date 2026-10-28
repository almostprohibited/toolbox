FROM debian:trixie-slim

LABEL org.opencontainers.image.source=https://github.com/almostprohibited/backend

RUN apt update && \
    apt install -y \
        tini \
        ca-certificates \
        xvfb \
        libglib2.0-0 \
        libnspr4 \
        libnss3 \
        libatk1.0-0 \
        libatk-bridge2.0-0t64 \
        libcups2t64 \
        libxkbcommon0 \
        libasound2t64 \
        libgbm1 \
        libcairo2 \
        libpango-1.0-0 \
        libxcomposite1 \
        libxdamage1 \
        libxfixes3 \
        libxrandr2 \
        curl \
        unzip \
        xauth \
        socat && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L https://storage.googleapis.com/chrome-for-testing-public/154.0.8037.92/linux64/chrome-linux64.zip -o /tmp/chrome.zip && \
    unzip /tmp/chrome.zip -d /tmp/unpacked-chrome && \
    mv /tmp/unpacked-chrome/* /root/chrome && \
    rm -rf /tmp/chrome.zip /tmp/unpacked-chrome

COPY chrome.sh /root/start.sh
RUN chmod +x /root/start.sh

ENTRYPOINT ["tini", "--"]
CMD ["/root/start.sh"]
