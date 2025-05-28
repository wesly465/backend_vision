FROM php:8.2-apache

# Instala dependencias necesarias
RUN apt-get update && \
    apt-get install -y libzip-dev zip libicu-dev && \
    docker-php-ext-install intl

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia los archivos del proyecto
COPY . /var/www/html

# Define directorio de trabajo
WORKDIR /var/www/html

# Instala dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# Habilita módulos de Apache
RUN a2enmod rewrite

# Exponer el puerto
EXPOSE 80
