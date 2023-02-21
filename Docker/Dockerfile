# escape=`

FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022


WORKDIR /source
COPY DemoApplication.zip .


WORKDIR /certs
COPY /certs .


WORKDIR /scripts
COPY /scripts .


SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressReference = 'SilentlyContinue';"]


RUN .\ConfigureServer.ps1
RUN .\DeployApplication.ps1 TestSite TestApp