# Usa PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Copia archivos al contenedor
COPY . /var/www/html/

# Habilita rewrite para CodeIgniter
RUN a2enmod rewrite

# Reemplaza el archivo de configuración de Apache
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Da permisos
RUN chown -R www-data:www-data /var/www/html/writable
