#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER zabbixweb WITH PASSWORD 'zabb1xWebDbSecr3t';
    CREATE DATABASE zabbixwebdb;
    GRANT ALL PRIVILEGES ON DATABASE zabbixwebdb TO zabbixweb;
EOSQL
