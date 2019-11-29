FROM php:7.4.0-apache

RUN a2dissite 000-default.conf

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN apt-get install -y --no-install-recommends git zip unzip

# Data
VOLUME /data
COPY docker /
COPY . /app/pinedocs
WORKDIR /app/pinedocs

# Install Composer dependencies
RUN composer install

# Override entrypoint
# To make sure data directory exists and symlinks are set when containers are being run.
RUN ["chmod", "+x", "/usr/bin/entrypoint"]
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["apache2-foreground"]
