
# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o /out

# Stage 2: Run
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Expose port 5000 from Kestrel webserver
EXPOSE 5000
EXPOSE 5001

# Tell Kestrel to listen on port 5000 and serve plain HTTP
ENV ASPNETCORE_URLS http://*:5000
# ENV ASPNETCORE_URLS https://+;http://+
# ENV ASPNETCORE_HTTPS_PORT 5001
ENV ASPNETCORE_ENVIRONMENT Production
# This is critical for the Azure AD signin flow to work in Kubernetes and App Service
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true
# ENV AZURE_TENANT_ID __SP_AZURE_TENANT_ID__
# ENV AZURE_CLIENT_ID __SP_AZURE_CLIENT_ID__
# ENV AZURE_CLIENT_SECRET __SP_AZURE_CLIENT_SECRET__

WORKDIR /app
COPY --from=build /out ./
ENTRYPOINT ["dotnet", "dotnet-demoapp.dll"]
