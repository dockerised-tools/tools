#!/usr/bin/env sh

set -eu

if [ "${PHP_EXT_ENABLE:-}" != "" ]; then
    docker-php-ext-enable ${PHP_EXT_ENABLE}
fi

php \
    -d memory_limit="${PHP_MEMORY_LIMIT:-512M}" \
    "${TOOL_BIN_PATHNAME}" \
    "${@}"
