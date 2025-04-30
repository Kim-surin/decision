#!/bin/bash

# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# WAS상의 Service가 정상 구동되었을때, 최초에 표시되는 화면 URI
_target_url="http://127.0.0.1:9080/loginform"

for i in `seq 1 10`;
do
  HTTP_CODE=$(curl --write-out '%{http_code}' -v -o /dev/null -m 10 -q -s "${_target_url}")
  if [ "$HTTP_CODE" == "200" ]; then
    echo "Successfully pulled root page."
    exit 0;
  fi
  echo "Attempt to curl endpoint returned HTTP Code $HTTP_CODE. Backing off and retrying."
  sleep 10
done
echo "Server did not come up after expected time. Failing."
exit 1