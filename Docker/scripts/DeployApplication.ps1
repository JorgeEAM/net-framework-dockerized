param([Parameter(Mandatory)]$siteName,[Parameter(Mandatory)]$applicationName)

<#
    Functions Block
#>
Function Add-Path($Path) {
    $Path = [Environment]::GetEnvironmentVariable("PATH", "Machine") + [IO.Path]::PathSeparator + $Path
    [Environment]::SetEnvironmentVariable( "Path", $Path, "Machine" )
}



$env:path = "${env:path};C:\Windows\System32\inetsrv";
Expand-Archive -Path "C:\source\DemoApplication.zip" -DestinationPath "C:\source\DemoApplication"
Write-Host $env:path;

<#
    Remove default web site content.
#>
#Remove-Website -Name 'Default Web Site';
Remove-Item -Recurse -Force C:\inetpub\wwwroot\*;


<#
    Creating WebSite and Application configuration. 
#>
appcmd add apppool /name:"${applicationName}-pool" /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated
appcmd add site /name:${siteName} /physicalPath:C:\inetpub\wwwroot\${siteName} /bindings:http/*:80:
appcmd start site "${siteName}"
appcmd add app /site.name:"${siteName}" /path:/"${applicationName}" /physicalPath:"C:\inetpub\wwwroot\${siteName}\${applicationName}"
appcmd set app "${siteName}/${applicationName}" /applicationPool:"${applicationName}-pool"
New-Item -Force -ItemType Directory -Path "C:\inetpub\wwwroot\${siteName}\${applicationName}\"
Get-ChildItem -Recurse -Path "C:\source\DemoApplication\*" | Move-Item -Destination "C:\inetpub\wwwroot\${siteName}\${applicationName}\";
