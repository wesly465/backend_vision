FROM php:8.2-apache

# Instala dependencias necesarias
RUN apt-get update && \
    apt-get install -y libzip-dev zip libicu-dev unzip && \
    docker-php-ext-install intl

# Instala Composer desde contenedor oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia archivos del proyecto al contenedor
COPY . /var/www/html

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Instala dependencias de PHP
RUN composer install --no-dev --optimize-autoloader

# Permisos para carpeta writable (requerido por CodeIgniter)
RUN chown -R www-data:www-data /var/www/html/writable && \
    chmod -R 775 /var/www/html/writable

# Habilita mod_rewrite de Apache
RUN a2enmod rewrite

# Reemplaza la configuración por la personalizada (ya apunta a public/)
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Mostrar errores (útil para depuración)
RUN echo "display_errors=On\nerror_reporting=E_ALL" > /usr/local/etc/php/conf.d/debug.ini

# Exponer el puerto por defecto
EXPOSE 80
