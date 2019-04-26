FROM postgres:9.5-alpine

RUN env | grep -i postgres

RUN mkdir -p /docker-entrypoint-initdb.d/
ADD ./init-user-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-user-db.sh