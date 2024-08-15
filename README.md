[日本語版 README はこちら](https://github.com/ponta0/PaperMC-Docker-Build/blob/main/README-ja.md)

# PaperMC Docker Container

## About This Image
This Docker image runs [PaperMC](https://papermc.io/), a fork of the Minecraft server software.

- Base Image: [Amazon Corretto](https://hub.docker.com/_/amazoncorretto)
- Supported Architectures: `linux/amd64`, `linux/arm64`
- GitHub Repository: [ponta0/PaperMC-Docker-Build](https://github.com/ponta0/PaperMC-Docker-Build)
- Docker Hub Repository: [magnia/papermc](https://hub.docker.com/r/magnia/papermc)

## Tagging Policy
If you specify a Minecraft version as a tag, the latest build will be fetched. To get a specific build, append `-${BUILD_NUMBER}` to the version.

## Usage
```bash
MINECRAFT_VERSION="1.21.1"
# For a specific build tag
# BUILD_NUMBER="123"
# MINECRAFT_VERSION="1.21.1-${BUILD_NUMBER}"
docker run -d \
  -p 25565:25565 \
  -e EULA=true \
  -v /path/to/data:/opt/PaperMC/data \
  --name papermc \
  magnia/papermc:${MINECRAFT_VERSION}
```

## Environment Variables
- **EULA** (default: empty): Set to `true` to agree to the Minecraft EULA.
- **JAVA_ARGS** (default: `-Xms4G -Xmx4G`): Configure Java arguments.

## Volumes
- `/opt/PaperMC/data`: Stores necessary PaperMC data, including `server.properties` and world data.



