@description('Name of the Key Vault')
param keyVaultName string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('SKU for the Key Vault')
param skuName string = 'standard'

@description('Whether to enable soft delete for the Key Vault')
param enableSoftDelete bool = true

@secure()
@description('The value of the secret to be stored in the Key Vault')
param weatherApiKey string

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

resource weatherApiKeySecret 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: 'WeatherApiKey'
  parent: keyVault
  properties: {
    value: weatherApiKey
  }
}

output keyVaultId string = keyVault.id
output keyVaultUri string = keyVault.properties.vaultUri
