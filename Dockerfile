FROM jolokia/tomcat-8.0

MAINTAINER chris@cbeer.info

ENV DSPACE_VERSION 4.1
ENV DEPLOY_DIR /dspace/webapps
ENV DSPACE_ANT_OPTS -Ddspace.configuration=/dspace/config/dspace.cfg

# install maven
RUN apt-get install -y maven

# install ant
RUN apt-get install -y ant

# install psql client
RUN apt-get install -y postgresql-client

ADD configure-and-run-dspace.sh /tmp/configure-and-run-dspace.sh
ADD seed-dspace-database.sh /tmp/seed-dspace-database.sh
ADD setenv.sh /opt/tomcat/bin/setenv.sh

# get dspace
RUN cd /tmp/; curl -L https://github.com/DSpace/DSpace/archive/dspace-${DSPACE_VERSION}.tar.gz | tar xz

# build it
RUN mkdir /dspace
RUN cd /tmp/DSpace-dspace-${DSPACE_VERSION} && mvn package

RUN cd /tmp/DSpace-dspace-${DSPACE_VERSION}/dspace/target/dspace-${DSPACE_VERSION}-build  && ant init_installation && ant init_configs && ant install_code && ant -Dwars=true copy_webapps && ant init_geolite
RUN cp /dspace/webapps/*.war /opt/tomcat/webapps

CMD /tmp/configure-and-run-dspace.sh
