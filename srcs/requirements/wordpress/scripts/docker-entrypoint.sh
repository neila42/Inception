#!/bin/sh

# Update wp-config-sample.php with environment variables
update_wp_config() {
    sed -i "s/username_here/$DB_USER/g" wp-config-sample.php
    sed -i "s/password_here/$DB_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$DB_HOST/g" wp-config-sample.php
    sed -i "s/database_name_here/$DB_NAME/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php
}

# Install WordPress if not already installed
install_wordpress() {
    if ! wp core is-installed --path=/var/www/html --quiet; then
        echo "Installing WordPress..."
        wp core install \
            --url="https://mydomain.com" \
            --title="MyProject" \
            --admin_user="admin" \
            --admin_password="admin_password" \
            --admin_email="admin@example.com" \
            --path=/var/www/html \
            --skip-email
    fi
}

# Main script execution
update_wp_config
sleep 10
install_wordpress

# Set proper permissions
chown -R www-data:www-data wp-content/uploads

# Install and activate plugins and themes
wp plugin install wordpress-importer --activate
wp import /usr/local/bin/inception.xml --authors=create
wp theme install twentytwentytwo --activate

# Start PHP-FPM
exec php-fpm81 -F
