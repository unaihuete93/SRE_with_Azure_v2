param location string
param environmentName string
param containerAppName string
param containerImage string
param cpuCores int
param memorySize string
param logAnalyticsWorkspaceId string
param appConfigEndpoint string
param logAnalyticsWorkspaceGuid string
param userMiId string
param acrName string

resource containerEnv 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: environmentName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspaceGuid
        sharedKey: listKeys(logAnalyticsWorkspaceId, '2021-06-01').primarySharedKey
      }
    }
  }
}

resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerAppName
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
        '${userMiId}': {}
    }
  }
  properties: {
    managedEnvironmentId: containerEnv.id
    configuration: {
      ingress: {
        external: true
        targetPort: 5000
      }
      registries: [
        {
          server: '${acrName}.azurecr.io'
          identity: userMiId
        }
      ]
    }
    template: {
      containers: [
        {
          name: containerAppName
          image: containerImage
          resources: {
            cpu: cpuCores
            memory: memorySize
          }
          env: [
            {
              name: 'APP_CONFIG_END'
              value: appConfigEndpoint
            }
          ]
        }
      ]
    }
  }
}





