param name string
param location string
param policyTier string // Dynamically passed ('Basic', 'Standard', 'Premium')
param threatIntelMode string  // Dynamically passed ('AlertOnly', 'Deny', etc.)
param enableDnsProxy bool = false  // DNS proxy setting (Standard & Premium)
param dnsSettings string = 'AzureProvided'  // Default to Azure provided DNS
param tags object

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-05-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      tier: policyTier  // Dynamic tier ('Basic', 'Standard', 'Premium')
    }
    threatIntelMode: threatIntelMode  // Dynamic threat intelligence mode
    
    // DNS Settings for Standard and Premium tiers
    @if (policyTier != 'Basic') {
      dnsSettings: {
        servers: []  // Empty unless custom DNS servers are passed
        proxySettings: {
          enableProxy: enableDnsProxy  // DNS proxy enabled/disabled dynamically
        }
      }
    }

    // IDPS only for Premium tier
    @if (policyTier == 'Premium') {
      intrusionDetection: {
        mode: 'Deny'  // Intrusion Detection and Prevention System mode
      }
    }
  }
}
