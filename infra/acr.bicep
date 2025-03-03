param acrName string
param location string = resourceGroup().location
param sku string = 'Basic'

resource acr 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: true
  }
}

output acrLoginServer string = acr.properties.loginServer
//output acrAdminUsername string = acr.listCredentials().username
//output acrAdminPassword string = acr.listCredentials().passwords[0].value
