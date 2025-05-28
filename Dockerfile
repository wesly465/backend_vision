FROM php:8.2-apache

# Instala dependencias necesarias
RUN apt-get update && \
    apt-get install -y libzip-dev zip libicu-dev unzip && \
    docker-php-ext-install intl

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia los archivos del proyecto
COPY . /var/www/html

# Define directorio de trabajo
WORKDIR /var/www/html

# Instala dependencias PHP (ignora intl si tienes problemas)
RUN composer install --no-dev --optimize-autoloader

# Establece permisos para almacenamiento y caché
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 775 /var/www/html/writable

# Habilita mod_rewrite para URLs amigables
RUN a2enmod rewrite

# Reemplaza configuración Apache para usar el directorio public/
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Expone el puerto 80
EXPOSE 80
