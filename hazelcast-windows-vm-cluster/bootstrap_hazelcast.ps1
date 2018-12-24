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

& .\install_hazelcast.ps1

$python = 'C:\Python37\python.exe'
$java = 'C:\Program Files\Java\jdk1.8.0_191\bin\java.exe'
$mvn = 'C:\ProgramData\chocolatey\bin\mvn.exe'
refreshenv
& $mvn --version
& $python -V
& $java -version

& $python .\modify_configuration.py --cluster-name=$clusterName --cluster-password=$clusterPassword --subscription-id=$subscriptionId --aad-client-id=$aadClientId --aad-client-secret=$aadClientSecret --tenant-id=$aadTenantId --group-name=$groupName --cluster-tag=$clusterTag --filename=.\hazelcast.xml | Out-File -FilePath C:\modify.log
Copy-Item .\hazelcast.xml -Destination C:\Temp\hazelcast

& $mvn exec:java --file "C:\Temp\hazelcast\pom.xml" | Out-File -FilePath C:\maven.log