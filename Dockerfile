FROM  mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /source

COPY devops.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app .
EXPOSE 5000
ENTRYPOINT ["dotnet" ,"devops.dll"]