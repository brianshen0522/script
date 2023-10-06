#!/bin/bash

KEYCLOAK_HOST_DEFAULT="152.38.3.196"
# FILE_NAME="test"
read -r -p "Oauth Conf file name:" FILE_NAME
read -r -p "Endpoint URL:" ENDPOINT_URL
read -r -p "Keycloak Server address(default:${KEYCLOAK_HOST_DEFAULT}):" KEYCLOAK_HOST
KEYCLOAK_HOST="${KEYCLOAK_HOST:-$KEYCLOAK_HOST_DEFAULT}"
read -r -p "Keycloak Client ID:" CLIENT_ID
read -r -p "Keycloak Client Secret:" CLIENT_SECRET
read -r -p "Oauth Proxy Port:" PROXY_PORT

PROXY_URL_DEFAULT="${KEYCLOAK_HOST}"
read -r -p "Oauth Proxy URL(default: http://${PROXY_URL_DEFAULT}):" PROXY_URL
PROXY_URL="${PROXY_URL:-$PROXY_URL_DEFAULT}"


if [ -n "${FILE_NAME}" ] && [ -n "${ENDPOINT_URL}" ] && [ -n "${CLIENT_ID}" ] && [ -n "${CLIENT_SECRET}" ] && [ -n "${PROXY_PORT}" ] && [ -n "${PROXY_URL}" ] && [ -n "${KEYCLOAK_HOST}" ]
then
    cp template.cfg "${FILE_NAME}"
    sed -i -e "21s@ENDPOINT_URL@${ENDPOINT_URL}@" "${FILE_NAME}"
    sed -i -e "s@KEYCLOAK_HOST@${KEYCLOAK_HOST}@g" "${FILE_NAME}"
    sed -i -e "55s@CLIENT_ID@${CLIENT_ID}@" "${FILE_NAME}"
    sed -i -e "56s@CLIENT_SECRET@${CLIENT_SECRET}@" "${FILE_NAME}"
    sed -i -e "5s@PROXY_PORT@${PROXY_PORT}@" "${FILE_NAME}"
    sed -i -e "62s@PROXY_URL@${PROXY_URL}@" "${FILE_NAME}"
else
    echo "Input Data Error"
fi