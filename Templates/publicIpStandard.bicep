param pipName string
param location string
param ipVersion string
param sku string
param zone array
param tier string
param assignment string
param routingPreference string
param ddosProtection bool
param tags object

resource publicIP 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: pipName
  location: location
  sku: {
    name: sku
    tier: tier
  }
  zones: zone
  properties: {
    publicIPAllocationMethod: assignment
    publicIPAddressVersion: ipVersion
    ddosSettings: {
      protectionMode: ddosProtection ? 'VirtualNetworkInherited' : 'Disabled'
    }
    idleTimeoutInMinutes: 4
  }
  tags: tags
}
