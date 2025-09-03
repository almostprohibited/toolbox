#!/bin/sh

chmod +x /bin/almostprohibited-indexer

# Alpine defaults to UTC, 7am UTC is 12am PST
echo "0 7 * * * /bin/almostprohibited-indexer --excluded-retailers prophet-river" >> /var/spool/cron/crontabs/root
# Prophet River seems to have their maintainance at 1am-4am MT, which is interesting
echo "30 6 * * * /bin/almostprohibited-indexer --retailers prophet-river" >> /var/spool/cron/crontabs/root

crond -b

exec "$@"
