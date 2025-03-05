param location string
param appConfigName string = 'srewithazure-appconfig'

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2021-03-01-preview' = {
  name: appConfigName
  location: location
  sku: {
    name: 'Standard'
  }
}

output appConfigId string = appConfig.id
output appConfigEndpoint string = appConfig.properties.endpoint
