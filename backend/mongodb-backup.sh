#! /usr/bin/env bash

set -euo pipefail

mkdir -p ./backups

datetime=$(date --iso-8601=seconds --utc)
docker compose exec mongo mongodump --uri="mongodb://root:root@localhost:27017" --archive | gzip > "./backups/mongodb-$datetime.gz"

# TODO: validate dump
# docker compose exec mongo mongorestore --dryRun <dump contents>
