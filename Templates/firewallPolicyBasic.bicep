param name string
param location string
param tier string
param tags object

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-11-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      tier: tier  // Only "tier" should be specified here for firewall policies
    }
    // Other firewall policy settings
  }
}
