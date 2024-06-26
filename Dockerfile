# FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
# WORKDIR /home

# RUN apt-get update && apt-get install -y git

# ARG REPO_URL
# ARG BRANCH
# RUN git clone --branch ${BRANCH} ${REPO_URL} .

# RUN dotnet restore

# RUN dotnet tool install --global dotnet-ef --version 7.0.14

# ENV PATH="${PATH}:/root/.dotnet/tools"

# RUN dotnet ef migrations add InitialCreate --project /home/DCMLockerServidor/Server/DCMLockerServidor.Server.csproj

# RUN dotnet ef database update --project /home/DCMLockerServidor/Server/DCMLockerServidor.Server.csproj

# # # Publica la aplicación
# # RUN dotnet publish -c Release -o /home/out

# # RUN dotnet dev-certs https --clean
# # RUN dotnet dev-certs https --check --verbose
# # RUN dotnet dev-certs https --trust

# # WORKDIR /home/out
# # ENTRYPOINT ["dotnet", "DCMLockerServidor.Server.dll"]



FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /home

RUN apt-get update && apt-get install -y git  

ARG REPO_URL
ARG BRANCH
RUN git clone --branch ${BRANCH} ${REPO_URL} .

RUN dotnet restore

RUN dotnet tool install --global dotnet-ef --version 7.0.14

ENV PATH="${PATH}:/root/.dotnet/tools"


# Descargar wait-for-it.sh
RUN apt-get install -y wget && \
    wget -O wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x wait-for-it.sh

WORKDIR /home/DCMLockerServidor/Server
RUN dotnet ef migrations add InitialCreate --project DCMLockerServidor.Server.csproj

WORKDIR /home/DCMLockerServidor/Server
RUN dotnet dev-certs https --clean
RUN dotnet dev-certs https --trust


RUN dotnet publish -c Release -o /home/out

