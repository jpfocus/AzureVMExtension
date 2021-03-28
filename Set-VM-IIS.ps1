Import-Module ServerManager
Add-WindowsFeature Web-Server
Add-WindowsFeature NET-Framework-Features, NET-Framework-Core
Install-WindowsFeature Web-Server, Web-WebServer, Web-Common-Http, Web-Default-Doc, Web-Dir-Browsing, Web-Http-Errors, Web-Static-Content, Web-Health, Web-Http-Logging, Web-Performance, Web-Stat-Compression, Web-Security, Web-Filtering, Web-App-Dev, Web-Net-Ext, Web-Net-Ext45, Web-Asp, Web-Asp-Net, Web-Asp-Net45, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Mgmt-Tools, Web-Mgmt-Console, Web-Mgmt-Compat, Web-Metabase, Web-Lgcy-Mgmt-Console, Web-Lgcy-Scripting, Web-WMI –IncludeManagementTools

New-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8081 -HostHeader ""
New-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 8082 -HostHeader ""

New-NetFirewallRule -DisplayName "iis-8081" -Direction Inbound -LocalPort 8081 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "iis-8082" -Direction Inbound -LocalPort 8082 -Protocol TCP -Action Allow

Add-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value $($env:computername)

New-Item -ItemType directory -Path "C:\inetpub\wwwroot\images"
New-Item -ItemType directory -Path "C:\inetpub\wwwroot\video"

$imagevalue = "Images: " + $($env:computername)
Add-Content -Path "C:\inetpub\wwwroot\images\test.htm" -Value $imagevalue

$videovalue = "Video: " + $($env:computername)
Add-Content -Path "C:\inetpub\wwwroot\video\test.htm" -Value $videovalue    
