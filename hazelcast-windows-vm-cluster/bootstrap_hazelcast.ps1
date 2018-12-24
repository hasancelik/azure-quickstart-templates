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

java -version
mvn --version

mvn exec:java --file "C:\Temp\hazelcast\pom.xml"