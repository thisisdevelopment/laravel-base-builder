FROM thisisdevelopment/php:8.3-fpm

USER root
RUN apt-get update && apt-get install -y jq
USER www-data
RUN composer global require squizlabs/php_codesniffer
