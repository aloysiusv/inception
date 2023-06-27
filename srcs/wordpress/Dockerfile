FROM alpine:3.17.3

RUN apk update && apk upgrade && apk add --no-cache wget mariadb-client \
    php81 php81-fpm php81-mysqli php81-phar php81-iconv \
	php81-curl php81-json php81-ftp php81-dom php81-fileinfo \
	php81-mbstring php81-openssl php81-exif php81-xml php81-simplexml\
    php81-zip php81-intl php81-sodium php81-xmlreader php81-zlib php81-sockets \
	php81-session php81-tokenizer && \
    mkdir -p /var/www/ && \
	wget https://wordpress.org/wordpress-6.2.tar.gz -P /var/www/ && \
	cd /var/www/ && \
	tar -xzf wordpress-6.2.tar.gz && \
	rm wordpress-6.2.tar.gz

COPY ./conf/www.conf /etc/php81/php-fpm.d/

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/install.sh /tmp/install.sh

ENTRYPOINT [ "sh", "/tmp/install.sh" ]