param location string = resourceGroup().location
param environmentName string = 'srewithazurev2-aca-env'
param containerAppName string = 'srewithazurev2-aca-app'
param containerImage string 
param cpuCores int = 1
param memorySize string = '1.0Gi'
param appInsightsName string = 'srewithazurev2-app-insights'
param keyVaultName string = 'srewithazurev2-keyvault'

module logAnalyticsModule 'modules/log-analytics.bicep' = {
  name: 'logAnalyticsDeployment'
  params: {
    location: location
  }
}

module appConfigModule 'modules/app-config.bicep' = {
  name: 'appConfigDeployment'
  params: {
    location: location
    appInsightsConnectionString: appInsightsModule.outputs.appInsightsConnString
  }
}

module appInsightsModule 'modules/app-insights.bicep' = {
  name: 'appInsightsDeployment'
  params: {
    location: location
    appInsightsName: appInsightsName
  }
}

module keyVaultModule 'modules/key-vault.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    keyVaultName: keyVaultName
    location: location
  }
}

module containerAppModule 'modules/container-app.bicep' = {
  name: 'containerAppDeployment'
  params: {
    location: location
    environmentName: environmentName
    containerAppName: containerAppName
    containerImage: containerImage
    cpuCores: cpuCores
    memorySize: memorySize
    logAnalyticsWorkspaceId: logAnalyticsModule.outputs.workspaceId
    logAnalyticsWorkspaceGuid: logAnalyticsModule.outputs.workspaceGuid
    appConfigEndpoint: appConfigModule.outputs.appConfigEndpoint
  }
}
