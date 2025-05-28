# Usa imagen con Apache y PHP 8.2
FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libicu-dev \
    zip \
    git \
    && docker-php-ext-install intl pdo_mysql zip

# Habilitar mod_rewrite para CodeIgniter
RUN a2enmod rewrite

# Copiar archivos de la app al contenedor
COPY . /var/www/html/

# Establecer permisos
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Cambiar el DocumentRoot
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Exponer puerto
EXPOSE 80
