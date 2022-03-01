FROM bisand/dotnet-runtime AS base
WORKDIR /app

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
# RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
# USER appuser

FROM bisand/dotnet-build AS build
WORKDIR /src
COPY ["demo/demo.csproj", "demo/"]
RUN dotnet restore "demo/demo.csproj"
COPY . .
WORKDIR "/src/demo"
RUN dotnet build "demo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "demo.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "demo.dll"]
