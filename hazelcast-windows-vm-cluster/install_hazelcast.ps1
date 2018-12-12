# Param(
#     [string]$minHeapSize,
#     [string]$maxHeapSize
# )

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install jdk8 -y
choco install maven -y
choco install python -y

New-Item -ItemType directory -Force -Path C:\Temp\hazelcast

# copy hazelcast.xml and pom.xml into C:\Temp\hazelcast

Copy-Item .\pom.xml -Destination C:\Temp\hazelcast
Copy-Item .\hazelcast.xml -Destination C:\Temp\hazelcast

Copy-Item .\bootstrap_hazelcast.ps1 -Destination C:\Temp\hazelcast
Copy-Item .\modify_configuration -Destination C:\Temp\hazelcast