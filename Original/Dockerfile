# escape=`

FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022

WORKDIR /inetpub/wwwroot

SHELL ["powershell"]


RUN Remove-Website -Name 'Default Web Site';
RUN Remove-Item -Recurse -Force C:\inetpub\wwwroot\*;
RUN New-Website -Name 'TestSite' -Port 80 -PhysicalPath C:\inetpub\wwwroot\;
RUN New-WebApplication -Name 'TestApp' -Site 'TestSite' -PhysicalPath C:\inetpub\wwwroot\;
RUN dism /online /enable-feature /featurename:IIS-ASPNET45 /all;

COPY ./Content .
COPY ./Content .\TestSite\TestApplication
