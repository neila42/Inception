#!/bin/sh

# Verify if MariaDB has been initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Setting up MariaDB data directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    echo "Starting MariaDB for initial setup..."
    mysqld_safe --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &
    pid=$!

    echo "Waiting for MariaDB to become available..."
    for i in {1..30}; do
        if mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; then
            echo "MariaDB is now available."
            break
        fi
        sleep 1
    done

    if [ $i -eq 31 ]; then
        echo >&2 'MariaDB initialization process failed.'
        exit 1
    fi

    echo "Executing initialization scripts..."
    for script in /docker-entrypoint-initdb.d/*; do
        case "$script" in
            *.sh)  echo "Running script $script"; . "$script" ;;
            *.sql) echo "Running SQL file $script"; mysql --socket=/var/run/mysqld/mysqld.sock < "$script" ;;
            *)     echo "Ignoring $script" ;;
        esac
    done

    echo "Stopping MariaDB after initialization..."
    if ! mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root shutdown; then
        echo >&2 "Unable to properly shut down MariaDB."
        exit 1
    fi
else
    echo "MariaDB data directory already set up."
fi

echo "Starting MariaDB server..."
exec mysqld_safe --user=mysql
