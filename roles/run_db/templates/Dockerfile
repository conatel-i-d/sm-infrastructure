FROM postgres:{{ pg_version }}

RUN mkdir -p /docker-entrypoint-initdb.d

COPY ./00_setup_db.sql /docker-entrypoint-initdb.d/

RUN chown -R postgres:postgres /docker-entrypoint-initdb.d