FROM postgres:9.6-alpine

ADD postgres/init/* /docker-entrypoint-initdb.d/
RUN ls -la /docker-entrypoint-initdb.d/