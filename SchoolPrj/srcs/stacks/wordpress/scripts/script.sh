#!/bin/bash

WP_PATH='/var/www/html'

# Verify that if Wordpress is alerady installed or not
if [ ! -e ${WP_PATH}/wp-config.php ]; then
  # Download wp-cli
  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar

  # Download WordPress
  ./wp-cli.phar core download --allow-root --path=${WP_PATH}

  # Configure wp-config.php
  ./wp-cli.phar config create --allow-root \
    --dbname=${MYSQL_DB} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASS} \
    --dbhost=${MYSQL_HOST} \
    --path=${WP_PATH}


  # Setup WordPress
  ./wp-cli.phar core install --allow-root \
    --url=${WP_HOME_URL} \
    --title=${WP_BLOG_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --path=${WP_PATH}


# Create Non Admin User
  ./wp-cli.phar user create --allow-root \
    --role=author ${WP_USER} ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASS} \
    --path=${WP_PATH}
fi

# Start PHP-FPM process
exec php-fpm7.3 -F
