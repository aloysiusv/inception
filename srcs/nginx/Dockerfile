FROM alpine:3.17.3

RUN apk update && apk add --no-cache nginx openssl && \
        mkdir -p /var/log/nginx

RUN openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes \
                -out /etc/ssl/certs/lrandria.crt \
                -keyout /etc/ssl/certs/lrandria.key \
                -subj "/C=FR/ST=France/L=Paris/O=42/CN=lrandria.42.fr"

COPY ./conf/mynginx.conf /etc/nginx/http.d/default.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]