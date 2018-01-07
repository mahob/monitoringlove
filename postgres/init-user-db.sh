#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER grafana WITH PASSWORD 'gra7anaDbSecr3t';
    CREATE DATABASE grafanadb;
    GRANT ALL PRIVILEGES ON DATABASE grafanadb TO grafana;
EOSQL
