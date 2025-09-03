#! /usr/bin/env bash

set -euo pipefail

mkdir -p ./backups

datetime=$(date --iso-8601=seconds --utc)
VOLUME_PATH=./ docker compose exec mongo mongodump --uri="mongodb://root:root@localhost:27017" --archive | gzip > "./backups/mongodb-$datetime.gz"

# TODO: validate dump
# gzip -d "./backups/mongodb-$datetime.gz"
# docker compose exec mongo mongorestore --archive="mongodb-$datetime" --uri="mongodb://root:root@localhost:27017" --dryRun
