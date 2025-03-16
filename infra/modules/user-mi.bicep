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
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b12aa53e-6015-4669-9d5e-3d5e5662c884') // App Configuration Data Reader role
        principalId: userAssignedIdentity.properties.principalId
        principalType: 'ServicePrincipal'
    }
}

resource keyVaultReaderRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    name: guid(userAssignedIdentity.id, 'keyvault-reader')
    scope: resourceGroup()
    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b86a8fe4-44ce-4948-aee5-eccb2c155cd7') // Key Vault Reader role
        principalId: userAssignedIdentity.properties.principalId
        principalType: 'ServicePrincipal'
    }
}

output resourceId string = userAssignedIdentity.id
