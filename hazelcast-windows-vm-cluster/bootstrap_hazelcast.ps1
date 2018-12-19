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

Write-Host "Installing tools and copying files"
.\install_hazelcast.ps1
Write-Host "Finished"
Write-Host "Run python file"
python .\modify_configuration.py --cluster-name=$clusterName --cluster-password=$clusterPassword --subscription-id=$subscriptionId --aad-client-id=$aadClientId --aad-client-secret=$aadClientSecret --tenant-id=$aadTenantId --group-name=$groupName --cluster-tag=$clusterTag --filename=hazelcast.xml > C:\modify.log
Write-Host "Finished"

Write-Host "Copying hazelcast.xml"
Copy-Item .\hazelcast.xml -Destination C:\Temp\hazelcast
Write-Host "Finished"

mvn exec:java -f C:\Temp\hazelcast\pom.xml > C:\maven.log