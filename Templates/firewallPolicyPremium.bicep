param name string
param location string
param threatIntelMode string  // e.g., 'AlertOnly', 'Deny'
param enableDnsProxy bool = false  // Option to enable or disable DNS proxy
param idps string = 'None'  // Only used for Premium tier (Deny, Allow, etc.)
param tags object
param tier string  // Add tier as a parameter

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-11-01' = {
  name: name
  location: location
  tags: tags

  properties: {
    sku: {
      tier: tier  // Use the tier parameter here
    }
    threatIntelMode: threatIntelMode
    dnsSettings: {
      enableProxy: enableDnsProxy
    }
    intrusionDetection: {
      mode: idps
    }
  }
}
