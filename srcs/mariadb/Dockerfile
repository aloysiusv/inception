FROM alpine:3.17.3

RUN apk update && \
    apk upgrade && \
    apk add --no-cache mariadb mariadb-client mariadb-common && \
    sed -i 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/' \
           /etc/my.cnf.d/mariadb-server.cnf && \
    mkdir -p /run/mysqld/ && chown -R mysql:mysql /run/mysqld

COPY tools/mdb_setup.sh /tmp/mdb_setup.sh

ENTRYPOINT ["sh", "/tmp/mdb_setup.sh"]