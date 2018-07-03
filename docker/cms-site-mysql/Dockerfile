FROM hippocms/cms-site-base:12

COPY mysql-connector-java-5.1.46.jar ${CATALINA_BASE}/common/lib/mysql-connector-java-5.1.46.jar

COPY repository-mysql.xml ${CATALINA_BASE}/conf/repository.xml
ENV REPO_CONFIG "file:${CATALINA_BASE}/conf/repository.xml"

COPY context-default-mysql.xml ${CATALINA_BASE}/conf/context.xml

#docker build -t hippocms/cms-site-mysql:12 .


