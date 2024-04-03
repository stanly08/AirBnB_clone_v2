#!/usr/bin/env bash
# Sets up web servers for deployment of web_static

# Install Nginx if not already installed
if ! dpkg -s nginx > /dev/null 2>&1; then
    apt-get update
    apt-get -y install nginx
fi

# Create necessary directories if they don't exist
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/

# Create a fake HTML file
echo "Holberton School" > /data/web_static/releases/test/index.html

# Create or recreate the symbolic link
rm -f /data/web_static/current
ln -s /data/web_static/releases/test/ /data/web_static/current

# Set ownership of directories
chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
config_file="/etc/nginx/sites-available/default"
sed -i '/^location \/hbnb_static {/i \        alias /data/web_static/current/;' "$config_file"

# Restart Nginx
service nginx restart
