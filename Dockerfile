# Usa PHP con Apache
FROM php:8.2-apache

# Habilita módulos necesarios
RUN docker-php-ext-install pdo pdo_mysql
# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
# Copia archivos al contenedor
COPY . /var/www/html/

# Habilita rewrite y headers
RUN a2enmod rewrite headers

# Copia archivo de configuración de Apache si tienes uno (opcional)
# COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Establece permisos (opcional)
RUN chown -R www-data:www-data /var/www/html

# Expone el puerto
EXPOSE 80
