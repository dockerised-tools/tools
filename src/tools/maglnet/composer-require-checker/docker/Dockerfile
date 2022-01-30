ARG PHP_DOCKER_IMAGE
ARG COMPOSER_DOCKER_IMAGE

FROM ${COMPOSER_DOCKER_IMAGE} as composer

FROM ${PHP_DOCKER_IMAGE} as tool

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

ENV COMPOSER_HOME /composer
ENV TOOL_BIN_PATHNAME=/usr/local/bin/composer-require-checker

ARG TOOL_VERSION

RUN \
    composer global require maglnet/composer-require-checker:${TOOL_VERSION} \
    && ln -s /composer/vendor/bin/composer-require-checker ${TOOL_BIN_PATHNAME}

WORKDIR /app

ENTRYPOINT ["php", "-d", "memory_limit=512M", "${TOOL_BIN_PATHNAME}"]
