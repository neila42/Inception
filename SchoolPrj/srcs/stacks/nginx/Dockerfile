FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
 apt-get install -y nginx && \
 apt-get install -y openssl


RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes \
    -out /etc/nginx/ssl/nginx-certificate.crt \
    -keyout /etc/nginx/ssl/nginx-certificate.key \
    -subj "/CN="
    
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]