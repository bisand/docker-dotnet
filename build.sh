#!/bin/sh
# Current version: https://dotnetcli.azureedge.net/dotnet/Runtime/Current/latest.version
# LTS version: https://dotnetcli.azureedge.net/dotnet/Runtime/LTS/latest.version

DOTNET_VERSION_DEFAULTVALUE=$(wget -qO - https://dotnetcli.azureedge.net/dotnet/Runtime/LTS/latest.version)
DOTNET_VERSION="${1:-$DOTNET_VERSION_DEFAULTVALUE}"

echo "building images for dotnet version: $DOTNET_VERSION"

sudo docker build --build-arg dotnet_version="--version ${DOTNET_VERSION}" dotnet-build/. -t bisand/dotnet-build:$DOTNET_VERSION
sudo docker build --build-arg dotnet_version="--version ${DOTNET_VERSION}" dotnet-runtime/. -t bisand/dotnet-runtime:$DOTNET_VERSION
sudo docker build --build-arg dotnet_version="--version ${DOTNET_VERSION}" dotnet-runtime-asp/. -t bisand/dotnet-runtime-asp:$DOTNET_VERSION

sudo docker tag bisand/dotnet-build:$DOTNET_VERSION bisand/dotnet-build:latest
sudo docker tag bisand/dotnet-runtime:$DOTNET_VERSION bisand/dotnet-runtime:latest
sudo docker tag bisand/dotnet-runtime-asp:$DOTNET_VERSION bisand/dotnet-runtime-asp:latest

# sudo docker push --all-tags bisand/dotnet-build
# sudo docker push --all-tags bisand/dotnet-runtime
# sudo docker push --all-tags bisand/dotnet-runtime-asp
