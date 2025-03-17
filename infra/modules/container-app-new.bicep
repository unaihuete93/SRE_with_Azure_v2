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
param usermiClientId string
param revisionName string = ''

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
        traffic: [
          {
            latestRevision: true
            weight: 0
          }
          {
            latestRevision: false
            weight: 100
            revisionName: revisionName
          }
        ]
      }
      activeRevisionsMode: 'multiple'
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
            {
              name: 'AZURE_CLIENT_ID'
              value: usermiClientId
            }
          ]
        }
      ]
    }
  }
}

