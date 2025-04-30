#!/bin/bash

# param1: properties file name
_properties="was.properties"

# stop script can be failed, when application is not deployed before.
#set -e

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
  grep "${1}" "${_properties}" | cut -d '=' -f2
}

_webapp_name=$(readProperty 'webapp.name')
_active=$(systemctl is-active "tomcat-${_webapp_name}")

if [ "$_active" == "active" ]
then
  systemctl stop tomcat-"$_webapp_name"
fi