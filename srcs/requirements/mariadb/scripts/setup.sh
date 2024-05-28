#!/bin/sh

# Set default values for database configuration
DB_NAME=${DB_NAME:-mydatabase}
DB_USER=${DB_USER:-dbuser}
DB_PASSWORD=${DB_PASSWORD:-dbpassword}

# Generate SQL setup script
generate_setup_sql() {
    cat << EOF > /docker-entrypoint-initdb.d/setup.sql
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF
}

# Main script execution
generate_setup_sql
chmod +x /docker-entrypoint-initdb.d/setup.sql
