#!/bin/sh

chmod +x /bin/almostprohibited-indexer

# Alpine defaults to UTC, 7am UTC is 12am PST
echo "0 7 * * * /bin/almostprohibited-indexer --excluded-retailers prophet-river --excluded-retailers canadas-gun-store" >> /var/spool/cron/crontabs/root
echo "30 6 * * * /bin/almostprohibited-indexer -r prophet-river -r canadas-gun-store" >> /var/spool/cron/crontabs/root

crond -b

exec "$@"
