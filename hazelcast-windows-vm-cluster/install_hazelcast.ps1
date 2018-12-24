# Param(
#     [string]$minHeapSize,
#     [string]$maxHeapSize
# )

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install jdk8 -y
choco install maven -y
choco install python -y

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv

New-Item -ItemType directory -Force -Path C:\Temp\hazelcast

# copy and pom.xml into C:\Temp\hazelcast
Copy-Item .\pom.xml -Destination C:\Temp\hazelcast