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

# Repository Directory
ENV REPO_PATH "${CATALINA_BASE}/repository"

# Bootstrapping enabled?
ENV REPO_BOOTSTRAP "true"

# Repository Cluster Node ID
ENV CLUSTER_ID "$(whoami)-$(hostname -f)"

###############################################################################
# Remove existing artifacts and install new ones by extracting the tar ball
###############################################################################

RUN rm -rf ${CATALINA_BASE}/common/lib/*.jar
RUN rm -rf ${CATALINA_BASE}/shared/lib/*.jar
RUN rm -rf ${CATALINA_BASE}/webapps/*

COPY setenv.sh ${CATALINA_BASE}/bin/

#docker build -t hippocms/cms-site-base:12 .


