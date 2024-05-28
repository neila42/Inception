#!/bin/sh

# Create SSL directory
setup_ssl() {
    mkdir -p /etc/nginx/ssl
}

# Start Nginx in the foreground
start_nginx() {
    nginx -g 'daemon off;'
}

# Main script execution
setup_ssl
start_nginx
