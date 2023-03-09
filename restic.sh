#!/usr/bin/env bash
source /home/restic/env.sh

sudo /usr/bin/restic backup --tag develop /home/jan/develop

/usr/bin/restic forget --keep-last 2 --keep-monthly 3 --group-by tags
/usr/bin/restic prune
