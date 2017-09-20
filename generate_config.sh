#!/bin/bash

if [[ -f wordpress.conf ]]; then
  read -r -p "config file wordpress.conf exists and will be overwritten, are you sure you want to contine? [y/N] " response
  case $response in
    [yY][eE][sS]|[yY])
      mv wordpress.conf wordpress.conf_backup
      ;;
    *)
      exit 1
    ;;
  esac
fi

if [ -z "$WORDPRESS_HOSTNAME" ]; then
  read -p "Hostname (FQDN): " -ei "wordpress.example.org" WORDPRESS_HOSTNAME
fi

if [ -z "$WORDPRESS_ADMIN_MAIL" ]; then
  read -p "Wordpress admin Mail address: " -ei "mail@example.com" WORDPRESS_ADMIN_MAIL
fi

[[ -f /etc/timezone ]] && TZ=$(cat /etc/timezone)
if [ -z "$TZ" ]; then
  read -p "Timezone: " -ei "Europe/Berlin" TZ
fi


DBNAME=wordpress
DBUSER=wordpress
DBPASS=$(</dev/urandom tr -dc A-Za-z0-9 | head -c 28)

HTTP_PORT=80
HTTP_BIND_PORT=80


cat << EOF > wordpress.conf
# ------------------------------
# wordpress web ui configuration
# ------------------------------
# example.org is _not_ a valid hostname, use a fqdn here.
WORDPRESS_HOSTNAME=${WORDPRESS_HOSTNAME}

# ------------------------------
# WORDPRESS admin user
# ------------------------------
WORDPRESS_ADMIN=wordpressadmin
WORDPRESS_ADMIN_MAIL=${WORDPRESS_ADMIN_MAIL}
WORDPRESS_PASS=$(</dev/urandom tr -dc A-Za-z0-9 | head -c 28)

# ------------------------------
# SQL database configuration
# ------------------------------
DBNAME=${DBNAME}
DBUSER=${DBUSER}

# Please use long, random alphanumeric strings (A-Za-z0-9)
DBPASS=${DBPASS}
DBROOT=$(</dev/urandom tr -dc A-Za-z0-9 | head -c 28)

# ------------------------------
# Bindings
# ------------------------------

# You should use HTTPS, but in case of SSL offloaded reverse proxies:
HTTP_PORT=${HTTP_PORT}
HTTP_BIND=0.0.0.0
HTTP_BIND_PORT=${HTTP_BIND_PORT}

# Your timezone
TZ=${TZ}

# Fixed project name
COMPOSE_PROJECT_NAME=dc_wp1

EOF
