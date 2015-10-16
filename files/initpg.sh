#!/bin/bash

if [ ! -d /var/lib/postgresql/9.4/main ]; then

    MY_USER=docker
    MY_PASS=docker
    MY_DBNAME=docker

    if [ -n "$PG_USER" ]; then
        MY_USER="$PG_USER"
    fi

    if [ -n "$PG_PASS" ]; then
        MY_PASS="$PG_PASS"
    fi

    if [ -n "$PG_DBNAME" ]; then
        MY_DBNAME="$PG_DBNAME"
    fi

    /usr/lib/postgresql/9.4/bin/pg_ctl initdb -D /var/lib/postgresql/9.4/main

    # init postgresql
    /etc/init.d/postgresql start && \
        psql --command "CREATE USER $MY_USER WITH SUPERUSER PASSWORD '$MY_PASS';" && \
        createdb -O "$MY_USER" -E UTF8 -T template0 "$MY_DBNAME" && \
        /etc/init.d/postgresql stop

    # allow host connection with md5 password
    echo "host $MY_DBNAME  $MY_USER    0.0.0.0/0  md5" >> /etc/postgresql/9.4/main/pg_hba.conf

    # allow connection from all IP address
    echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf

fi

chmod -R 700 /var/lib/postgresql
