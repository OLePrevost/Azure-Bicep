param name string
param location string
param policyTier string // 'Basic', 'Standard', 'Premium'
param threatIntelMode string // 'AlertOnly', 'Deny', etc.
param enableDnsProxy bool = false // DNS proxy setting (for Standard & Premium)
param dnsSettings string = 'AzureProvided' // Default DNS setting
param tags object

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-05-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      tier: policyTier // Passed as parameter
    }
    threatIntelMode: threatIntelMode // Passed as parameter

    // DNS Settings for Standard and Premium tiers
    @if(policyTier != 'Basic') {
      dnsSettings: {
        servers: [] // If you want to specify custom DNS servers, add them here
        proxySettings: {
          enableProxy: enableDnsProxy // DNS proxy setting passed dynamically
        }
      }
    }

    // IDPS only for Premium tier
    @if(policyTier == 'Premium') {
      intrusionDetection: {
        mode: 'Deny' // Intrusion Detection and Prevention System mode for Premium
      }
    }
  }
}
