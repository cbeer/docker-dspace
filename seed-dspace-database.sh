#!/bin/bash

cd /tmp/DSpace-dspace-${DSPACE_VERSION}/dspace/target/dspace-${DSPACE_VERSION}-build;
psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -c "CREATE USER dspace WITH LOGIN PASSWORD 'dspace';"
psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -c "CREATE DATABASE dspace;"
psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE dspace to dspace;"
sed -i "s#db.url = jdbc:postgresql://localhost:5432/dspace#db.url = jdbc:postgresql://${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/dspace#" /dspace/config/dspace.cfg;
cp -f /dspace/config/dspace.cfg config/dspace.cfg;
ant ${DSPACE_ANT_OPTS} test_database
ant ${DSPACE_ANT_OPTS} setup_database
/dspace/bin/dspace create-administrator -e ${admin_email:-archivist1@example.com} -f ${admin_firstname:-DSpace} -l ${admin_lastname:-Admin} -p ${admin_passwd:-archivist1} -c ${admin_language:-en}
