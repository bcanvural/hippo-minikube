FROM hippocms/cms-site-base:12

COPY h2-1.4.197.jar ${CATALINA_BASE}/common/lib/h2-1.4.197.jar

COPY repository-h2.xml ${CATALINA_BASE}/conf/repository.xml
ENV REPO_CONFIG "file:${CATALINA_BASE}/conf/repository.xml"

COPY context-default-h2.xml ${CATALINA_BASE}/conf/context.xml

#docker build -t hippocms/cms-site-h2:12 .


