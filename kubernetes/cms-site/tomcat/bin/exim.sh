#!/usr/bin/env bash

echo "Curling: ${INDEX_EXPORT_URL}"
curl -f ${INDEX_EXPORT_URL} -u admin:admin -o export.zip
rm -rf ${REPO_PATH}/workspaces/default/index/*
mkdir -p ${REPO_PATH}/workspaces/default/index/
unzip export.zip -d ${REPO_PATH}/workspaces/default/index/
