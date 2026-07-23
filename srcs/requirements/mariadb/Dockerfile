FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Директорія для сокета
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Конфіг
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Entrypoint
COPY tools/mariadb-init.sh /usr/local/bin/mariadb-init.sh
RUN chmod +x /usr/local/bin/mariadb-init.sh

EXPOSE 3306

ENTRYPOINT ["mariadb-init.sh"]
CMD ["mysqld"]
