FROM serversideup/php:8.4-fpm-nginx

ENV AUTORUN_ENABLED=true
ENV HEALTHCHECK_PATH="/up"
ENV PHP_OPCACHE_ENABLE=1
ENV SSL_MODE="mixed"

COPY --chown=www-data:www-data . /var/www/html/

RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

USER root

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get install -y nodejs
RUN node -v

USER www-data

RUN npm install
RUN npm run build
