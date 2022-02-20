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
    && ln -s /composer/vendor/bin/composer-require-checker ${TOOL_BIN_PATHNAME} \

    # Install common used dependencies and easy one to install
    && apk add --no-cache \
        # for docker-php-ext-enable
        binutils \
        # for bz2
        bzip2-dev \
        # for curl
        curl-dev \
        # for dom
        libxml2-dev \
        # for ffi
        libffi-dev \
        # for gd
        libpng-dev \
        # for gmp
        gmp-dev \
        # for intl
        icu-dev \
        # for sodium
        libsodium-dev \
        # for xsl
        libxslt-dev \
        # for zip
        libzip-dev \
    && docker-php-ext-install \
        bcmath \
        bz2 \
        calendar \
        ctype \
        curl \
        dba \
        dom \
        #enchant # Package 'enchant', required by 'virtual:world', not found
        exif \
        ffi \
        fileinfo \
        filter \
        ftp \
        gd \
        #gettext # configure: error: Cannot locate header file libintl.h
        gmp \
        #hash # already installed, could not be installed with docker-php-ext-install
        iconv \
        #imap # configure: error: utf8_mime2text() has new signature, but U8T_CANONICAL is missing. This should not happen. Check config.log for additional information.
        intl \
        #json # already installed, could not be installed with docker-php-ext-install
        #ldap # configure: error: Cannot find ldap.h
        #mbstring # already installed, could not be installed with docker-php-ext-install
        mysqli \
        #oci8 # configure: error: Oracle Instant Client directory /usr/lib/oracle/.../client64/lib libraries not found.
        #odbc # configure: error: ODBC header file '/usr/local/incl/sqlext.h' not found!
        opcache \
        pcntl \
        pdo \
        #pdo_dblib # configure: error: Cannot find FreeTDS in known installation directories
        #pdo_firebird # configure: error: libfbclient, libgds or libib_util not found!
        pdo_mysql \
        #pdo_oci # configure: error: You need to tell me where to find your Oracle Instant Client SDK, or set ORACLE_HOME.
        #pdo_odbc # configure: error: Unknown ODBC flavour yes
        #pdo_pgsql # configure: error: Cannot find libpq-fe.h. Please specify correct PostgreSQL installation path
        #pdo_sqlite # Package 'sqlite3', required by 'virtual:world', not found
        #pgsql # configure: error: Cannot find libpq-fe.h. Please specify correct PostgreSQL installation path
        phar \
        posix \
        #pspell # configure: error: Cannot find pspell
        #readline # Package 'libedit', required by 'virtual:world', not found
        #reflection # already installed, could not be installed with docker-php-ext-install
        session \
        shmop \
        simplexml \
        #snmp # configure: error: Could not find net-snmp-config binary. Please check your net-snmp installation.
        soap \
        sockets \
        sodium \
        #spl # already installed, could not be installed with docker-php-ext-install
        #standard # configure: error: Please ensure the argon2 header and library are installed
        sysvmsg \
        sysvsem \
        sysvshm \
        #tidy # configure: error: Cannot find libtidy
        #tokenizer # make: *** No rule to make target '/usr/src/php/ext/tokenizer/Zend/zend_language_parser.y', needed by '/usr/src/php/ext/tokenizer/Zend/zend_language_parser.c'.  Stop.
        xml \
        #xmlreader # make: *** [Makefile:209: php_xmlreader.lo] Error 1
        xmlwriter \
        xsl \
        zip \
    # Remove configuration of installed extensions, execute docker-php-ext-enable to enable it
    && rm /usr/local/etc/php/conf.d/docker-php-ext* \

    # Remove installation of binutil in docker-php-ext-enable, it's already installed here to be faster
    && sed -i "s/apk add --no-cache --virtual '.docker-php-ext-enable-deps' binutils/\# binutils is already installed/g" "$(which docker-php-ext-enable)" \
    && sed -i "s/apkDel='.docker-php-ext-enable-deps'/\echo 'foo' \> \/dev\/null \# to have code in if/g" "$(which docker-php-ext-enable)" \

    # Purge
    && rm -rf /usr/local/bin/composer /composer/.htaccess /composer/cache /composer/composer.json /composer/composer.lock \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

WORKDIR /app

COPY entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
