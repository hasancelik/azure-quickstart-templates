$CLUSTER_NAME=$args[0]
$CLUSTER_PASSWORD=$args[1]
$SUBSCRIPTION_ID=$args[2]
$AAD_CLIENT_ID=$args[3]
$AAD_CLIENT_SECRET=$args[4]
$AAD_TENANT_ID=$args[5]
$GROUP_NAME=$args[6]
$CLUSTER_TAG=$args[7]

python .\modify_configuration --cluster-name=$CLUSTER_NAME --cluster-password=$CLUSTER_PASSWORD --subscription-id=$SUBSCRIPTION_ID --aad-client-id=$AAD_CLIENT_ID --aad-client-secret=$AAD_CLIENT_SECRET --tenant-id=$AAD_TENANT_ID --group-name=$GROUP_NAME --cluster-tag=$CLUSTER_TAG --filename=hazelcast.xml
& .\install_hazelcast.ps1

mvn exec:java -f C:\Temp\hazelcast\pom.xml