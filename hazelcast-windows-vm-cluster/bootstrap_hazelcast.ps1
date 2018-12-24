param (
    [string]$clusterName,
    [string]$clusterPassword,
    [string]$subscriptionId,
    [string]$aadClientId,
    [string]$aadClientSecret,
    [string]$aadTenantId,
    [string]$groupName,
    [string]$clusterTag
)

. .\install_hazelcast.ps1
refreshenv

# $python = 'C:\Python37\python.exe'
# & $python -V

# $java = 'C:\Program Files\Java\jdk1.8.0_191\bin\java.exe'
# $mvn = 'C:\ProgramData\chocolatey\bin\mvn.exe'
# & $java -version
# & $mvn --version

python -V
java -version
mvn --version

Get-Command java | Select-Object Version
Get-Command java | Select-Object Source
Get-Command mvn | Select-Object Version
Get-Command mvn | Select-Object Source
Get-Command python | Select-Object Version
Get-Command python | Select-Object Source

python .\modify_configuration.py --cluster-name=$clusterName --cluster-password=$clusterPassword --subscription-id=$subscriptionId --aad-client-id=$aadClientId --aad-client-secret=$aadClientSecret --tenant-id=$aadTenantId --group-name=$groupName --cluster-tag=$clusterTag --filename=.\hazelcast.xml | Out-File -FilePath C:\modify.log
Copy-Item .\hazelcast.xml -Destination C:\Temp\hazelcast

mvn exec:java --file "C:\Temp\hazelcast\pom.xml" | Out-File -FilePath C:\maven.log