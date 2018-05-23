#!/bin/bash

npm install -g yarn

/etc/init.d/postgresql start

sleep 5

psql -c "CREATE DATABASE $DB_NAME" -U postgres
psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASS'" -U postgres
psql -c "ALTER ROLE $DB_USER SET client_encoding TO 'utf8'" -U postgres
psql -c "ALTER ROLE $DB_USER SET default_transaction_isolation TO 'read committed'" -U postgres
psql -c "ALTER ROLE $DB_USER SET timezone TO 'UTC'" -U postgres
psql -c "ALTER USER $DB_USER CREATEDB" -U postgres

psql -U postgres -lqt | cut -d \| -f 1 

pip install -r requirements.txt
pip install service_identity
yarn install
