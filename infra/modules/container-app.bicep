param location string
param environmentName string
param containerAppName string
param containerImage string
param cpuCores int
param memorySize string
param logAnalyticsWorkspaceId string
param appConfigEndpoint string
param acrName string

resource containerEnv 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: environmentName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspaceId
      }
    }
  }
}

resource containerApp 'Microsoft.App/containerApps@2024-10-02-preview' = {
  name: containerAppName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    managedEnvironmentId: containerEnv.id
    configuration: {
      ingress: {
        external: true
        targetPort: 5000
      }
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


resource acrRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(containerApp.id, 'acrpull')
  scope: resourceId('Microsoft.ContainerRegistry/registries', acrName)
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d') // AcrPull role
    principalId: containerApp.identity.principalId
  }
}
