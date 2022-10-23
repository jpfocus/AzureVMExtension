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



# $folder_img = "C:\inetpub\wwwroot\images"
# $curFolder = $folder_img
# if (-not (Test-Path $curFolder)) { New-Item -ItemType directory -Path $curFolder }
# "Images: " + $($env:computername) | Out-String | Out-File "$curFolder\test.htm"  -Encoding utf8 


# $folder_videos = "C:\inetpub\wwwroot\videos"
# if (-not (Test-Path $folder_videos)) { New-Item -ItemType directory -Path $folder_videos }
# "Videos: " + $($env:computername) | Out-String | Out-File "$folder_videos\test.htm"  -Encoding utf8 


# $folder1 = "C:\inetpub\wwwroot\folder1"
# if (-not (Test-Path $folder1)) { New-Item -ItemType directory -Path $folder1 }
# "$folder1<br>" + $($env:computername) | Out-String | Out-File "$folder1\test.htm" -Encoding utf8 


# $folder2 = "C:\inetpub\wwwroot\folder2"
# if (-not (Test-Path $folder2)) { New-Item -ItemType directory -Path $folder2 }
# "$folder2<br>" + $($env:computername) | Out-String | Out-File "$folder2\test.htm" -Encoding utf8 
