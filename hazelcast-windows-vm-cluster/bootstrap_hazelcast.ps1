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

.\install_hazelcast.ps1
python .\modify_configuration.py --cluster-name=$clusterName --cluster-password=$clusterPassword --subscription-id=$subscriptionId --aad-client-id=$aadClientId --aad-client-secret=$aadClientSecret --tenant-id=$aadTenantId --group-name=$groupName --cluster-tag=$clusterTag --filename=hazelcast.xml
Copy-Item .\hazelcast.xml -Destination C:\Temp\hazelcast

mvn exec:java -f C:\Temp\hazelcast\pom.xml