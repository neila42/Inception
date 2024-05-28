#!/bin/sh

# Function to check if MariaDB is ready
check_mariadb_ready() {
    i=0
    while [ $i -lt 30 ]; do
        if mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; then
            echo "MariaDB is ready."
            return 0
        fi
        i=$((i+1))
        sleep 1
    done
    echo >&2 'MariaDB init process failed.'
    exit 1
}

initialize_mariadb() {
    echo "Initializing MariaDB Data Directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    echo "Starting MariaDB..."
    mysqld_safe --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &
    pid=$!

    echo "Waiting for MariaDB to be ready..."
    check_mariadb_ready

    # Execute scripts
    echo "Running initialization scripts..."
    if [ -d /docker-entrypoint-initdb.d/ ]; then
        for script in /docker-entrypoint-initdb.d/*; do
            case "$script" in
                *.sh) echo "Running $script"; sh "$script" ;;
                *.sql) echo "Running $script"; mysql --socket=/var/run/mysqld/mysqld.sock < "$script" ;;
                *) echo "Ignoring $script" ;;
            esac
        done
    fi
    mysql --socket=/var/run/mysqld/mysqld.sock < /docker-entrypoint-initdb.d/setup.sql

    # Shut down the temporary instance
    echo "Shutting down MariaDB..."
    mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root shutdown
}

# Main script execution
if [ ! -d "/var/lib/mysql/mysql" ]; then
    initialize_mariadb
else
    echo "MariaDB Data Directory already initialized."
fi

echo "Starting MariaDB server..."
exec mysqld_safe --user=mysql
