###############################################################################
# Base Image
###############################################################################

FROM tomcat:8.5-jre8

# Tomcat Base Directory, inherited from the base image by default.
ENV CATALINA_BASE "/usr/local/tomcat"

# Customize catalina.properties to add additional common and shared loader jar paths.
RUN sed -i s:common.loader=\.\*:common.loader=\${catalina.base}/lib,\${catalina.base}/lib/\*\.jar,\${catalina.base}/common/lib/\*\.jar,\${catalina.home}/lib,\${catalina.home}/lib/\*\.jar:g ${CATALINA_BASE}/conf/catalina.properties
RUN sed -i s:shared.loader=\.\*:shared.loader=\${catalina.base}/shared/classes,\${catalina.base}/shared/lib/\*\.jar:g ${CATALINA_BASE}/conf/catalina.properties

###############################################################################
# Environment Variable Configurations
###############################################################################

# JVM Heap Size
ENV MIN_HEAP_SIZE "1024m"
ENV MAX_HEAP_SIZE "2048m"

# Repository Configuration File
ARG REPOSITORY_XML=tomcat/conf/repository-mysql.xml
COPY ${REPOSITORY_XML} ${CATALINA_BASE}/conf/repository.xml
ENV REPO_CONFIG "file:${CATALINA_BASE}/conf/repository.xml"

# Repository Directory
ENV REPO_PATH "${CATALINA_BASE}/repository"

# Bootstrapping enabled? #Keep commented-out
#ENV REPO_BOOTSTRAP "false" #Manage this in kubernetes so we can have single dockerfile for cms-site and site-only

# Index Export Zip file download URIs (e.g, file path that could possibly be shared through a shared Docker Volume).
# Note: You can set space-separated string to specify multiple URIs including SFTP, HTTP, HTTPS, etc. See index-init.sh for detail.
ENV INDEX_EXPORT_ZIP "/data/index/index-export-latest.zip"

# Repository Cluster Node ID
ENV CLUSTER_ID "$(whoami)-$(hostname -f)"

###############################################################################
# Remove existing artifacts and install new ones by extracting the tar ball
###############################################################################

RUN rm -rf ${CATALINA_BASE}/common/lib/*.jar
RUN rm -rf ${CATALINA_BASE}/shared/lib/*.jar
RUN rm -rf ${CATALINA_BASE}/webapps/*

ARG SETENV_SH=tomcat/bin/setenv.sh
COPY ${SETENV_SH} ${CATALINA_BASE}/bin/

ARG INDEX_INIT_SH=tomcat/bin/index-init.sh
COPY ${INDEX_INIT_SH} ${CATALINA_BASE}/bin/

#Index export stuff
RUN apt-get update && apt-get -y install unzip
COPY tomcat/bin/exim.sh ${CATALINA_BASE}/bin/

COPY mysql-connector-java-5.1.46.jar ${CATALINA_BASE}/common/lib/mysql-connector-java-5.1.46.jar
ARG TAR_BALL=*.tar.gz
ADD ${TAR_BALL} ${CATALINA_BASE}/