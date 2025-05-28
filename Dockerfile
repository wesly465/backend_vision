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

# Habilita rewrite y headers
RUN a2enmod rewrite headers

# Copia archivo de configuración de Apache si tienes uno (opcional)
# COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Establece permisos (opcional)
RUN chown -R www-data:www-data /var/www/html

# Expone el puerto
EXPOSE 80
