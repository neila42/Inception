FROM debian:buster

ARG MYSQL_DB
ARG MYSQL_USER
ARG MYSQL_PASS
ARG MYSQL_ROOT_PASS

WORKDIR /tmp

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY scripts/script.sh .

RUN service mysql start && sh script.sh

EXPOSE 3306

CMD ["mysqld"]