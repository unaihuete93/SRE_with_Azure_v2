// /workspaces/SRE_with_Azure_v2/infra/modules/user-mi.acr/main.bicep

param name string
//param resourceGroupName string
param location string

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
    name: name
    location: location
}


resource acrRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    name: guid(userAssignedIdentity.id, 'acrpull')
    scope: resourceGroup()
    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d') // AcrPull role
        principalId: userAssignedIdentity.properties.principalId
        principalType: 'ServicePrincipal'
    }
    
}

resource appConfigReaderRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    name: guid(userAssignedIdentity.id, 'appconfig-reader')
    scope: resourceGroup()
    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '516239f1-63e1-4d78-a4de-a74fb236a071') // App Configuration Data Reader role
        principalId: userAssignedIdentity.properties.principalId
        principalType: 'ServicePrincipal'
    }
}

resource keyVaultReaderRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    name: guid(userAssignedIdentity.id, 'keyvault-reader')
    scope: resourceGroup()
    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6') // Key Vault Secrets Users role
        principalId: userAssignedIdentity.properties.principalId
    }
}

output resourceId string = userAssignedIdentity.id
