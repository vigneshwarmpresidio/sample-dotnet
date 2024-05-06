# Use the official .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /service
ARG GPR_AUTH_TOKEN

# Copy everything from the current directory
COPY . ./

# Configure NuGet authentication token
RUN sed "s/_GPR_AUTH_TOKEN/${GPR_AUTH_TOKEN}/g" ./ops/NuGet.Config.Template > $HOME/.nuget/NuGet/NuGet.Config

# Restore dependencies as distinct layers
RUN dotnet restore

# Build and publish a release
RUN dotnet publish Sorenson.AccountServices.MmxApiAdapter.Service/Sorenson.AccountServices.MmxApiAdapter.Service.csproj -c Release -o ./out

# Use the official .NET ASP.NET Core runtime image as the base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /service

# Copy the build output from the build-env stage
COPY --from=build-env /service/out .

ENV ASPNETCORE_URLS="http://+:8080"

# Set the entrypoint for the application
ENTRYPOINT ["dotnet", "Sorenson.AccountServices.MmxApiAdapter.Service.dll"]
