#!/bin/sh

set -e

export -p > /root/env.sh
chmod 600 /root/env.sh

exec "$@"
