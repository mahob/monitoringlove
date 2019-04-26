#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER zabbix WITH PASSWORD 'zabb1xDbSecr3t';
    CREATE DATABASE zabbixdb;
    GRANT ALL PRIVILEGES ON DATABASE zabbixdb TO zabbix;
EOSQL
