# Build Stage
FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /dotnetmvc

COPY dotnetmvc.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -o /publish

# Runtime Image Stage
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "dotnetmvc.dll"]