# Build Stage
FROM microsoft/aspnetcore-build:2 AS build-env
WORKDIR /dotnetmvc

COPY dotnetmvc.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -o /publish

# Runtime Image Stage
FROM microsoft/aspnetcore:2
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "dotnetmvc.dll"]