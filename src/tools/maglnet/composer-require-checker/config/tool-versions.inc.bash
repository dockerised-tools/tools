#!/usr/bin/env bash

set -eu

readonly TOOL_VERSIONS=(
    3.0.0
    3.1.0
    3.2.0
    3.3.1
    3.4.0
    3.5.1
    3.6.0
    3.7.0
    3.8.0
    4.0.0
)

readonly TOOL_LATEST_MINOR_VERSIONS=(
    3.8.0
    4.0.0
)

readonly TOOL_LATEST_VERSION=4.0.0
