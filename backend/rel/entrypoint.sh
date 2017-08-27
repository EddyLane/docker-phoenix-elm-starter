#!/usr/bin/env bash

set -e

echo "Waiting for database to become available"
/bin/wait-for-it.sh -t 120 ${POSTGRES_HOST}:${POSTGRES_PORT}

/opt/app/bin/playlist_pal $@