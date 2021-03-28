Import-Module ServerManager
Add-WindowsFeature Web-Server
Add-WindowsFeature NET-Framework-Features, NET-Framework-Core
Install-WindowsFeature Web-Server, Web-WebServer, Web-Common-Http, Web-Default-Doc, Web-Dir-Browsing, Web-Http-Errors, Web-Static-Content, Web-Health, Web-Http-Logging, Web-Performance, Web-Stat-Compression, Web-Security, Web-Filtering, Web-App-Dev, Web-Net-Ext, Web-Net-Ext45, Web-Asp, Web-Asp-Net, Web-Asp-Net45, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Mgmt-Tools, Web-Mgmt-Console, Web-Mgmt-Compat, Web-Metabase, Web-Lgcy-Mgmt-Console, Web-Lgcy-Scripting, Web-WMI –IncludeManagementTools


$webBinding1 = Get-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8081 -HostHeader "" -ErrorVariable "notPresent" -ErrorAction SilentlyContinue
if ($null -eq $webBinding1) {
    New-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8081 -HostHeader ""
}
$webBinding2 = Get-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8082 -HostHeader "" -ErrorVariable "notPresent" -ErrorAction SilentlyContinue
if ($null -eq $webBinding2) {
    New-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8082 -HostHeader ""
}


$netFirewallRule1 = Get-NetFirewallRule -DisplayName "iis-8081" -ErrorVariable "notPresent" -ErrorAction SilentlyContinue
if ($null -eq $netFirewallRule1) {
    $netFirewallRule1 = New-NetFirewallRule -DisplayName "iis-8081" -Direction Inbound -LocalPort 8081 -Protocol TCP -Action Allow
}
$netFirewallRule2 = Get-NetFirewallRule -DisplayName "iis-8082" -ErrorVariable "notPresent" -ErrorAction SilentlyContinue
if ($null -eq $netFirewallRule2) {
    $netFirewallRule2 = New-NetFirewallRule -DisplayName "iis-8082" -Direction Inbound -LocalPort 8082 -Protocol TCP -Action Allow
}

Add-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value $($env:computername)

$folder_img = "C:\inetpub\wwwroot\images"
if (-not (Test-Path $folder_img)) {
    New-Item -ItemType directory -Path $folder_img
}
$folder_video = "C:\inetpub\wwwroot\video"
if (-not (Test-Path $folder_video)) {
    New-Item -ItemType directory -Path $folder_video
}

$imagevalue = "Images: " + $($env:computername)
$imageHtmlPath = "$folder_img\test.htm" 
$imagevalue | Out-String | Out-File $imageHtmlPath -Encoding utf8 


$videovalue = "Video: " + $($env:computername)
$videoHtmlPath = "$folder_video\test.htm" 
$videovalue | Out-String | Out-File $videoHtmlPath -Encoding utf8 
