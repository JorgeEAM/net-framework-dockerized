param([Parameter(Mandatory)]$siteName,[Parameter(Mandatory)]$applicationName)
<#
    Expanding ZIP file & deploy application.
#>
Get-ChildItem -Path "C:\source"
Expand-Archive -Path "C:\source\DemoApplication.zip" -DestinationPath "C:\source";
Get-ChildItem -Path "C:\source"

<#
    Remove default web site content.
#>
Remove-Website -Name 'Default Web Site';
Remove-Item -Recurse -Force C:\inetpub\wwwroot\*;

<#
    Creating WebSite and Application configuration. 
#>
New-Item -ItemType Directory -Path "C:\inetpub\wwwroot\${siteName}\${applicationName}";
New-Website -Name $siteName -Port 80 -PhysicalPath "C:\inetpub\wwwroot\${siteName}\";
New-WebApplication -Name $applicationName -Site $siteName -PhysicalPath "C:\inetpub\wwwroot\${siteName}\${applicationName}";
Get-Item -Path "C:\source\DemoApplication\*" | Move-Item -Destination "C:\inetpub\wwwroot\${siteName}\${applicationName}";