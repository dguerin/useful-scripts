Login-AzureRmAccount
Set-AzureRmContext -SubscriptionId 5225e119-fd7b-4018-b033-5f64f54579bb
$resourceProperties = @{
                   "KeyVaultId"="/subscriptions/5225e119-fd7b-4018-b033-5f64f54579bb/resourceGroups/developershelf-security/providers/Microsoft.KeyVault/vaults/developershelf"
                   "KeyVaultSecretName"="developershelfd6e13266-c1f5-4a14-8252-0e154e9490a6"
                   };
                  
New-AzureRmResource -Location "global" -Properties $resourceProperties -ResourceName "developershelf/developershelf" -ResourceType "microsoft.CertificateRegistration/certificateOrders/certificates" -ResourceGroupName "developershelf-security" -Force