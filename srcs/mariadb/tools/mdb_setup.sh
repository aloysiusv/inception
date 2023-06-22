#!/bin/sh

set -eux

if [ -d /var/lib/mysql/mysql ]; then
	echo "Already set up, starting..."
	exec /usr/bin/mysqld --user=mysql --skip-networking=0 --console $@
	exit 1
fi

touch tmp_mdb
chmod 755 tmp_mdb

echo "Setting up..."
mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

mariadb-install-db --auth-root-authentication-method=normal --basedir=/usr --datadir=/var/lib/mysql --skip-test-db --user=mysql

cat << eof > tmp_mdb
DELETE FROM mysql.user WHERE User = 'root';
FLUSH PRIVILEGES;
CREATE USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD' WITH GRANT OPTION;
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PWD');
CREATE USER '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL ON $DB_NAME.* TO '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD';
FLUSH PRIVILEGES;
eof

/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < tmp_mdb

rm -f tmp_mdb

exec /usr/bin/mysqld --user=mysql --skip-networking=0 --console $@