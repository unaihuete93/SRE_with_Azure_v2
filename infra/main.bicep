param location string = resourceGroup().location
param environmentName string = 'srewithazure-aca-env'
param containerAppName string = 'srewithazure-aca-app'
param containerImage string 
param cpuCores int = 1
param memorySize string = '1.0Gi'
param appInsightsName string = 'srewithazure-app-insights'

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
    appInsightsConnectionString: appInsightsModule.outputs.appInsightsInstrumentationKey
  }
}

module appInsightsModule 'modules/app-insights.bicep' = {
  name: 'appInsightsDeployment'
  params: {
    location: location
    appInsightsName: appInsightsName
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
    appConfigEndpoint: appConfigModule.outputs.appConfigEndpoint
  }
}
