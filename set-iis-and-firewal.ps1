Import-Module ServerManager
Add-WindowsFeature Web-Server
Add-WindowsFeature NET-Framework-Features, NET-Framework-Core
Install-WindowsFeature Web-Server, Web-WebServer, Web-Common-Http, Web-Default-Doc, Web-Dir-Browsing, Web-Http-Errors, Web-Static-Content, Web-Health, Web-Http-Logging, Web-Performance, Web-Stat-Compression, Web-Security, Web-Filtering, Web-App-Dev, Web-Net-Ext, Web-Net-Ext45, Web-Asp, Web-Asp-Net, Web-Asp-Net45, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Mgmt-Tools, Web-Mgmt-Console, Web-Mgmt-Compat, Web-Metabase, Web-Lgcy-Mgmt-Console, Web-Lgcy-Scripting, Web-WMI –IncludeManagementTools

# defalut iis site using the port_80

# add port_8081 to site bindings
$webBinding1 = Get-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8081 -HostHeader "" -ErrorVariable "notPresent" -ErrorAction SilentlyContinue
if ($null -eq $webBinding1) {
    New-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8081 -HostHeader ""
}
# add 8082 to site bindings
$webBinding2 = Get-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8082 -HostHeader "" -ErrorVariable "notPresent" -ErrorAction SilentlyContinue
if ($null -eq $webBinding2) {
    New-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8082 -HostHeader ""
}


# allow pc firewall 8081,8082 port inbound
$netFirewallRule1 = Get-NetFirewallRule -DisplayName "iis-8081" -ErrorVariable "notPresent" -ErrorAction SilentlyContinue
if ($null -eq $netFirewallRule1) {
    $netFirewallRule1 = New-NetFirewallRule -DisplayName "iis-8081" -Direction Inbound -LocalPort 8081 -Protocol TCP -Action Allow
}
$netFirewallRule2 = Get-NetFirewallRule -DisplayName "iis-8082" -ErrorVariable "notPresent" -ErrorAction SilentlyContinue
if ($null -eq $netFirewallRule2) {
    $netFirewallRule2 = New-NetFirewallRule -DisplayName "iis-8082" -Direction Inbound -LocalPort 8082 -Protocol TCP -Action Allow
}

# create index page
Add-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value $($env:computername)


$rootFolder = "C:\inetpub\wwwroot"

$curFolderName = "images"
$curFolder = "$($rootFolder)\$($curFolderName)"
if (-not (Test-Path $curFolder)) { New-Item -ItemType directory -Path $curFolder }
"$($curFolderName): " + $($env:computername) | Out-String | Out-File "$curFolder\test.htm" -Encoding utf8 

$curFolderName = "videos"
$curFolder = "$($rootFolder)\$($curFolderName)"
if (-not (Test-Path $curFolder)) { New-Item -ItemType directory -Path $curFolder }
"$($curFolderName): " + $($env:computername) | Out-String | Out-File "$curFolder\test.htm" -Encoding utf8 

$curFolderName = "folder1"
$curFolder = "$($rootFolder)\$($curFolderName)"
if (-not (Test-Path $curFolder)) { New-Item -ItemType directory -Path $curFolder }
"$($curFolderName): " + $($env:computername) | Out-String | Out-File "$curFolder\test.htm" -Encoding utf8 

$curFolderName = "folder2"
$curFolder = "$($rootFolder)\$($curFolderName)"
if (-not (Test-Path $curFolder)) { New-Item -ItemType directory -Path $curFolder }
"$($curFolderName): " + $($env:computername) | Out-String | Out-File "$curFolder\test.htm" -Encoding utf8 

if ($($env:computername).ToLower().Contains("vm1")) {
    $curFolderName = "folder3"
    $curFolder = "$($rootFolder)\$($curFolderName)"
    if (-not (Test-Path $curFolder)) { New-Item -ItemType directory -Path $curFolder }
    "$($curFolderName): " + $($env:computername) | Out-String | Out-File "$curFolder\test.htm" -Encoding utf8 
}
else {
    $curFolderName = "folder4"
    $curFolder = "$($rootFolder)\$($curFolderName)"
    if (-not (Test-Path $curFolder)) { New-Item -ItemType directory -Path $curFolder }
    "$($curFolderName): " + $($env:computername) | Out-String | Out-File "$curFolder\test.htm" -Encoding utf8 
}

