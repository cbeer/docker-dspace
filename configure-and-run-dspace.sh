#!/bin/bash

cd /tmp/DSpace-dspace-${DSPACE_VERSION}/dspace/target/dspace-${DSPACE_VERSION}-build;
sed -i "s#db.url = jdbc:postgresql://localhost:5432/dspace#db.url = jdbc:postgresql://${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/dspace#" /dspace/config/dspace.cfg;
cp -f /dspace/config/dspace.cfg config/dspace.cfg;
ant ${DSPACE_ANT_OPTS} test_database
/opt/tomcat/bin/deploy-and-run.sh
