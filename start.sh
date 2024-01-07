#! /usr/bin/env sh

set -e

export HYPERCORN_CONF="file:hypercorn_config.py"
export APP_MODULE="main:app"

exec hypercorn "${APP_MODULE}" -c "${HYPERCORN_CONF}"
