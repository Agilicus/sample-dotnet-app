FROM mcr.microsoft.com/dotnet/core/sdk:2.2-alpine AS build
COPY TodoApi /app

WORKDIR /app

RUN dotnet restore 
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-alpine
LABEL maintainer="don@agilicus.com"

WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "TodoApi.dll"]

