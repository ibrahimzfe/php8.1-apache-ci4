FROM php:8.1-apache

RUN apt update && apt upgrade -y 
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apt-get update
RUN apt-get install -y \
    git \
    zip \
    curl \
    sudo \
    unzip \
    libicu-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libreadline-dev \
    libfreetype6-dev \
    g++

RUN docker-php-ext-install \
    bz2 \
    intl \
    bcmath \
    opcache \
    calendar \
    pdo_mysql \
    mysqli

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite headers

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer
RUN composer self-update

COPY localhost.crt.pem /etc/ssl/certs/
COPY localhost.key.pem /etc/ssl/private/
#if you have CAROOT ssl put here
#COPY RootCA.crt /etc/ssl/certs/

COPY src/ /var/www/html/

RUN a2ensite 000-default
RUN a2enmod ssl

RUN chmod -R 777 /var/www/html/writable/
RUN service apache2 restart

EXPOSE 80
EXPOSE 443
EXPOSE 8080