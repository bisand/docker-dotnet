FROM alpine

ARG dotnet_channel
ARG dotnet_version

ENV CHANNEL=$dotnet_channel
ENV VERSION=$dotnet_version

# Install .net dependencies
RUN apk add bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib
RUN apk add libgdiplus --repository https://dl-3.alpinelinux.org/alpine/edge/testing/

# Add dotnet build user.
RUN adduser -u 5678 --disabled-password --gecos "" appuser \
    && mkdir /app && chown -R appuser /app \
    && chown -R appuser /home/appuser

# Change workdir to build user's dir
WORKDIR /home/appuser
USER appuser

RUN wget https://dot.net/v1/dotnet-install.sh
RUN chmod +x ./dotnet-install.sh
RUN sed -i "s|--waitretry 2||g" dotnet-install.sh
RUN sed -i "s|--connect-timeout 15|-T 15|g" dotnet-install.sh
RUN ./dotnet-install.sh --runtime dotnet --channel $CHANNEL --version $VERSION
RUN rm -f ./dotnet-install.sh

# Register dotnet cli to path
ENV DOTNET_ROOT="/home/appuser/.dotnet"
ENV PATH="${PATH}:${DOTNET_ROOT}"
