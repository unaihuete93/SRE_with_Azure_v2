@description('Name of the Key Vault')
param keyVaultName string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('SKU for the Key Vault')
param skuName string = 'standard'

@description('Whether to enable soft delete for the Key Vault')
param enableSoftDelete bool = true

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: skuName
    }
    tenantId: subscription().tenantId
    enableSoftDelete: enableSoftDelete
    enableRbacAuthorization: true
  }
}

output keyVaultId string = keyVault.id
output keyVaultUri string = keyVault.properties.vaultUri
