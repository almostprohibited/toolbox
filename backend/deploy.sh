#!/bin/bash

set -euo pipefail

sudo systemctl stop almostprohibited-backend-api.service
sudo systemctl stop almostprohibited-backend-indexer.timer
