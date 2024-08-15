#!/bin/bash

if [ -n "${EULA}" ] && [ "${EULA}" = "true" ]; then
    echo "eula=true" > /opt/PaperMC/data/eula.txt
fi

java -jar $JAVA_ARGS /opt/PaperMC/paper.jar $@
