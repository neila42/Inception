#!/bin/sh

# Check if MariaDB is already init
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB Data Directory..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    echo "Starting MariaDB temporarily..."
    mysqld_safe --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &
    pid=$!

    echo "Waiting for MariaDB to be ready..."
    for i in {1..30}; do
        if mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; then
            echo "MariaDB is ready."
            break
        fi
        sleep 1
    done

    if [ $i -eq 31 ]; then
        echo >&2 'MariaDB init process failed.'
        exit 1
    fi

    echo "Running initialization scripts..."
    for script in /docker-entrypoint-initdb.d/*; do
        case "$script" in
            *.sh)  echo "Running $script"; . "$script" ;;
            *.sql) echo "Running $script"; mysql --socket=/var/run/mysqld/mysqld.sock < "$script" ;;
            *)     echo "Ignoring $script" ;;
        esac
    done

    echo "Shutting down MariaDB..."
    if ! mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root shutdown; then
        echo >&2 "Failed to shut down MariaDB properly."
        exit 1
    fi
else
    echo "MariaDB Data Directory already initialized."
fi

echo "Starting MariaDB server..."
exec mysqld_safe --user=mysql
