param name string
param location string
param tier string  
param tags object

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2021-05-01' = {
  name: name // Use the 'name' parameter
  location: location // Use the 'location' parameter
  tags: tags
  sku: {
    name: 'AZFW_VNet'
    tier: tier  // Use the 'tier' parameter
  }
  properties: {
  }
}
