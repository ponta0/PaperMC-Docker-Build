[English README is here](https://github.com/ponta0/PaperMC-Docker-Build/README.md)

# PaperMC Dockerコンテナ

## このイメージについて
このDockerイメージでは、Minecraftサーバーのフォークである[PaperMC](https://papermc.io/)を実行できます。

- ベースイメージ: [Amazon Corretto](https://hub.docker.com/_/amazoncorretto)
- 対応アーキテクチャ: `linux/amd64`, `linux/arm64`
- GitHubリポジトリ: [ponta0/PaperMC-Docker-Build](https://github.com/ponta0/PaperMC-Docker-Build)

## タグの規則
タグとしてMinecraftバージョンを指定した場合、最新のビルドが取得されます。
もし、特定のビルドを取得する必要がある場合、バージョンの後に`-${ビルド番号}`を指定してください。

## 使い方
```bash
MINECRAFT_VERSION="1.21.1"
# タグを指定する場合
# BUILD_NUMBER="123"
# MINECRAFT_VERSION="1.21.1-${BUILD_NUMBER}"
docker run -d \
  -p 25565:25565 \
  -e EULA=true \
  -v /path/to/data:/opt/PaperMC/data \
  --name papermc \
  magnia/papermc:${MINECRAFT_VERSION}
```

## 環境変数
- **EULA** (デフォルト値: 空): `true`を設定することでMinecraft EULAに同意できます。
- **JAVA_ARGS** (デフォルト値: `-Xms4G -Xmx4G`): Javaの引数を設定することができます。

## ボリューム
- `/opt/PaperMC/data`: server.properties,ワールドデータ等のPaperMCが必要とするデータが格納されています。