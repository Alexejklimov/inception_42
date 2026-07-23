FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Створюємо директорію для SSL
RUN mkdir -p /etc/nginx/ssl

# Генеруємо самопідписаний сертифікат
# ВАЖЛИВО: CN не може братися з .env під час build
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=NA/L=NA/O=42/OU=Inception/CN=localhost"

# Копіюємо конфіг nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
