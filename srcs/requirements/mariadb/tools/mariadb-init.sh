#!/bin/bash
set -e

# read secrets
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

# if not initialized
if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;

-- root пароль
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- створення БД
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- створення користувача
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- права
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF
fi

# run MariaDB as PID 1
exec mysqld --user=mysql
