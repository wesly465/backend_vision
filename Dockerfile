FROM php:8.2-apache

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libzip-dev \
    zip \
    curl \
    && docker-php-ext-install pdo pdo_mysql

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia archivos de la app
COPY . /var/www/html/

# Instala dependencias de PHP
WORKDIR /var/www/html
RUN composer install --no-dev --optimize-autoloader

# Habilita módulos de Apache
RUN a2enmod rewrite headers

# Establece permisos adecuados
RUN chown -R www-data:www-data /var/www/html

# Puerto expuesto
EXPOSE 80
