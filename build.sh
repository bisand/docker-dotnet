#!/bin/sh
DOTNET_VERSION_DEFAULTVALUE=""
DOTNET_VERSION="${1:-$DOTNET_VERSION_DEFAULTVALUE}"

sudo docker build --build-arg dotnet_version="--version ${DOTNET_VERSION}" dotnet-build/. -t bisand/dotnet-build:$DOTNET_VERSION
sudo docker build --build-arg dotnet_version="--version ${DOTNET_VERSION}" dotnet-runtime/. -t bisand/dotnet-runtime:$DOTNET_VERSION
sudo docker build --build-arg dotnet_version="--version ${DOTNET_VERSION}" dotnet-runtime-asp/. -t bisand/dotnet-runtime-asp:$DOTNET_VERSION

sudo docker push bisand/dotnet-build:$DOTNET_VERSION
sudo docker push bisand/dotnet-runtime:$DOTNET_VERSION
sudo docker push bisand/dotnet-runtime-asp:$DOTNET_VERSION
