// Basic Firewall Policy Bicep Template

param name string
param location string
param threatIntelMode string  // e.g., 'AlertOnly', 'Deny'
param tags object

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-05-01' = {
  name: name
  location: location
  tags: tags

  properties: {
    sku: {
      tier: 'Basic'
    }
    threatIntelMode: threatIntelMode
  }
}
