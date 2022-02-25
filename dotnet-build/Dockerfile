ARG dotnet_version

FROM alpine
ENV VERSION=$dotnet_version

# Install .net dependencies
RUN apk add bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib
RUN apk add libgdiplus --repository https://dl-3.alpinelinux.org/alpine/edge/testing/

# Add dotnet build user.
RUN addgroup -S bob && adduser -S -g bob bob \
    && mkdir -p /home/bob/Downloads /home/bob/app \
    && chown -R bob:bob /home/bob/

# Change workdir to build user's dir
WORKDIR /home/bob

# Set owner to build user
RUN chown -R bob:bob /home/bob
USER bob

RUN wget https://dot.net/v1/dotnet-install.sh
RUN chmod +x ./dotnet-install.sh
RUN sed -i "s|--waitretry 2||g" dotnet-install.sh
RUN sed -i "s|--connect-timeout 15|-T 15|g" dotnet-install.sh
RUN ./dotnet-install.sh --channel LTS $VERSION
RUN rm -f ./dotnet-install.sh

# Register dotnet cli to path
ENV DOTNET_ROOT="/home/bob/.dotnet"
ENV PATH="${PATH}:${DOTNET_ROOT}"
