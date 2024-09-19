param name string
param location string
param policyTier string // Dynamically passed ('Basic', 'Standard', or other tiers)
param threatIntelMode string  // Dynamically passed ('AlertOnly', 'Deny', etc.)
param tags object

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-05-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      tier: policyTier  // Dynamically passed
    }
    threatIntelMode: threatIntelMode  // Dynamically passed
  }
}
