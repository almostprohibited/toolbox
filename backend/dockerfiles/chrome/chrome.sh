#!/bin/sh
socat TCP-LISTEN:9222,fork,reuseaddr,bind=0.0.0.0 TCP:127.0.0.1:9221 &

exec xvfb-run -a -s "-screen 0 1680x1050x24" /root/chrome/chrome \
  --no-sandbox \
  --remote-debugging-port=9221 \
  --user-data-dir=/data/profile \
  --disable-blink-features=AutomationControlled \
  --window-size=1680,1050 \
  --no-first-run \
  --lang=en_US
