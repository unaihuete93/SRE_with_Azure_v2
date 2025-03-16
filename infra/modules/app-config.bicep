param location string
param appConfigName string = 'srewithazurev2-appconfig'
param appInsightsConnectionString string

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2021-03-01-preview' = {
  name: appConfigName
  location: location
  sku: {
    name: 'Standard'
  }
}

resource appConfigKeyValue 'Microsoft.AppConfiguration/configurationStores/keyValues@2021-03-01-preview' = {
  parent: appConfig
  name: 'ApplicationInsights:ConnectionString'
  properties: {
    value: appInsightsConnectionString
    contentType: 'text/plain'
  }
}

resource appConfigKeyValue2 'Microsoft.AppConfiguration/configurationStores/keyValues@2021-03-01-preview' = {
  parent: appConfig
  name: 'Refresh:Config'
  properties: {
    value: '0'
    contentType: 'text/plain'
  }
}

resource appConfigKeyValue3 'Microsoft.AppConfiguration/configurationStores/keyValues@2021-03-01-preview' = {
  parent: appConfig
  name: 'AppConfig:Endpoint'
  properties: {
    value: appConfig.properties.endpoint
    contentType: 'text/plain'
  }
}

output appConfigId string = appConfig.id
output appConfigEndpoint string = appConfig.properties.endpoint

