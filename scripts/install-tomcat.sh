#!/bin/bash

# param1: properties file name
_properties="was.properties"

set -e

_program="$0"
while [ -h "$_program" ] ; do
  ls=$(ls -ld "$_program")
  link=$(expr "$ls" : '.*-> \(.*\)$')
  if expr "$link" : '/.*' > /dev/null; then
    _program="$link"
  else
    _program=$(dirname "$_program")/"$link"
  fi
done
_dir=$(dirname "$_program")

# properties path
_properties="$_dir"/properties/tomcat/"$_properties"
echo "Current"
echo "Read properties from ${_properties}"

function readProperty {
  grep "^${1}" "${_properties}" | cut -d '=' -f2
}

_webapp_name=$(readProperty 'webapp.name')
_webapp_port=$(readProperty 'webapp.port')
_shutdown_port=$(readProperty 'webapp.shutdown_port')
_artifact_name=$(readProperty 'webapp.artifact_name')

# use default WEBAPP_NAME if WEBAPP_NAME is not defined
WEBAPP_NAME="${_webapp_name:-ROOT}"
# use default WEBAPP_PORT if WEBAPP_PORT is not defined
WEBAPP_PORT="${_webapp_port:-9080}"
# use default SHUTDOWN_PORT if SHUTDOWN_PORT is not defined
SHUTDOWN_PORT="${_shutdown_port:-8005}"

CATALINA_HOME="/data/was/tomcat9"
CATALINA_BASE="${CATALINA_HOME}/${WEBAPP_NAME}"

APP_BASE="/data/was-app/${WEBAPP_NAME}"

echo "Install '${WEBAPP_NAME}' web application on port ${WEBAPP_PORT}. CATALINA_BASE=[${CATALINA_BASE}]"

# create paths of web application
mkdir -p "${CATALINA_BASE}"
mkdir -p "${CATALINA_BASE}/logs"
mkdir -p "${CATALINA_BASE}/bin"

cp -R ${CATALINA_HOME}/conf ${CATALINA_BASE}
echo "Paths for web application is created."

# grant tomcat user permissions to web application paths
chown -R tomcat:was "${CATALINA_BASE}"
echo "Permission is granted."

sed "s/WEBAPP_NAME/${WEBAPP_NAME}/g" "${_dir}"/templates/tomcat/server.xml | \
sed "s/WEBAPP_PORT/${WEBAPP_PORT}/g" | \
sed "s/SHUTDOWN_PORT/${SHUTDOWN_PORT}/g" \
> "${CATALINA_BASE}"/conf/server.xml

sed "s/WEBAPP_NAME/${WEBAPP_NAME}/g" "${_dir}"/templates/tomcat/tomcat.service \
> /usr/lib/systemd/system/tomcat-"${WEBAPP_NAME}".service

systemctl daemon-reload

TEMP_STAGING_DIR='/tmp/codedeploy-deployment-staging-area'
WAR_STAGED_LOCATION="$TEMP_STAGING_DIR/${_artifact_name}.war"

mkdir -p "${APP_BASE}"
cp $WAR_STAGED_LOCATION "${APP_BASE}/ROOT.war"
chown -R tomcat:was "${APP_BASE}"

systemctl start tomcat-"${WEBAPP_NAME}"