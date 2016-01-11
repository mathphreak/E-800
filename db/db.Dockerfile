FROM postgres:9.5
COPY init_db.sql /docker-entrypoint-initdb.d/
