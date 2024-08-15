#!/bin/bash

DOCKER_REPO_USER="magnia"
DOCKER_IMAGE_NAME="papermc"

function get_papermc_supported_java_version() {
    # https://docs.papermc.io/paper/getting-started
    MAJOR=$(echo ${1} | sed -E 's/^([0-9]+)\.([0-9]+)(\.([0-9]+))?(-(.+))?/\1/')
    MINOR=$(echo ${1} | sed -E 's/^([0-9]+)\.([0-9]+)(\.([0-9]+))?(-(.+))?/\2/')
    PATCH=$(echo ${1} | sed -E 's/^([0-9]+)\.([0-9]+)(\.([0-9]+))?(-(.+))?/\4/')
    LABEL=$(echo ${1} | sed -E 's/^([0-9]+)\.([0-9]+)(\.([0-9]+))?(-(.+))?/\6/')

    if [ ${MINOR} -ge 8 ] && [ ${MINOR} -le 11 ]; then
        echo 8
    elif [ ${MINOR} -ge 12 ] && [ ${MINOR} -le 16 ]; then
        if [ -n "${PATCH}" ] && [ "${PATCH}" -ge 5 ]; then
            echo 16
        else
            echo 11
        fi
    else
        echo 21
    fi
}

PAPERMC_VERSIONS=$(curl -sS -X "GET" "https://api.papermc.io/v2/projects/paper" -H "accept: application/json" | jq -r '.versions | join(" ")')
for PAPERMC_VERSION in ${PAPERMC_VERSIONS[@]}; do
    LATEST_BUILD_DETAILS=$(curl -sS -X "GET" "https://api.papermc.io/v2/projects/paper/versions/${PAPERMC_VERSION}/builds" -H "accept: application/json" | jq ".builds[-1]")
    LATEST_BUILD_NO=$( echo $LATEST_BUILD_DETAILS | jq -r ".build")
    LATEST_BUILD_FILENAME=$( echo $LATEST_BUILD_DETAILS | jq -r ".downloads.application.name")
    LATEST_BUILD_SHA256=$( echo $LATEST_BUILD_DETAILS | jq -r ".downloads.application.sha256")
    LATEST_BUILD_DOWNLOAD_URL="https://api.papermc.io/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${LATEST_BUILD_NO}/downloads/${LATEST_BUILD_FILENAME}"
    JAVA_VERSION=$(get_papermc_supported_java_version ${PAPERMC_VERSION})
    docker buildx build \
        --push \
        --platform linux/amd64,linux/arm64 \
        -t ${DOCKER_REPO_USER}/${DOCKER_IMAGE_NAME}:${PAPERMC_VERSION} \
        -t ${DOCKER_REPO_USER}/${DOCKER_IMAGE_NAME}:${PAPERMC_VERSION}-${LATEST_BUILD_NO} \
        --build-arg JAVA_VERSION=${JAVA_VERSION} \
        --build-arg PAPERMC_DOWNLOAD_URL=${LATEST_BUILD_DOWNLOAD_URL} \
        --build-arg PAPERMC_SHA256=${LATEST_BUILD_SHA256} \
        .
done
