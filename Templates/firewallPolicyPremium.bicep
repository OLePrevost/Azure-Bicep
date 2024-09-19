// Premium Firewall Policy Bicep Template

param name string
param location string
param threatIntelMode string  // e.g., 'AlertOnly', 'Deny'
param enableDnsProxy bool = false  // Option to enable or disable DNS proxy
param tags object

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-05-01' = {
  name: name
  location: location
  tags: tags

  properties: {
    sku: {
      tier: 'Premium'
    }
    threatIntelMode: threatIntelMode
    dnsSettings: {
      proxySettings: {
        enableProxy: enableDnsProxy
      }
    }
    intrusionDetection: {
      mode: 'Deny'  // Set to 'Deny' for IDPS in Premium tier
    }
  }
}
