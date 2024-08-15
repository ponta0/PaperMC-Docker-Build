ARG JAVA_VERSION

FROM amazoncorretto:${JAVA_VERSION}

WORKDIR /opt/PaperMC/data

ARG PAPERMC_DOWNLOAD_URL
ARG PAPERMC_SHA256

ENV JAVA_ARGS="-Xms4G -Xmx4G"

ADD --checksum=sha256:${PAPERMC_SHA256} ${PAPERMC_DOWNLOAD_URL} /opt/PaperMC/paper.jar

COPY --chmod=755 start.sh /opt

ENTRYPOINT [ "/opt/start.sh" ]
