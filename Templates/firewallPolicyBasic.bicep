param name string
param location string
param policyTier string  // 'Basic', 'Standard', 'Premium'
param threatIntelMode string  // 'AlertOnly', 'Deny', etc.
param enableDnsProxy bool = false  // DNS proxy setting for Standard & Premium
param dnsSettings string = 'AzureProvided'  // Default DNS setting
param tags object

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-05-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      tier: policyTier  // Passed as a parameter (Basic, Standard, Premium)
    }
    threatIntelMode: threatIntelMode  // Passed as a parameter

    // Conditional DNS Settings for Standard and Premium tiers
    @if (policyTier != 'Basic') {
      dnsSettings: {
        servers: []  // Customize DNS servers here if needed
        proxySettings: {
          enableProxy: enableDnsProxy  // Enable or disable DNS proxy based on the parameter
        }
      }
    }

    // Intrusion Detection and Prevention (IDPS) for Premium tier only
    @if (policyTier == 'Premium') {
      intrusionDetection: {
        mode: 'Deny'  // IDPS mode for Premium tier
      }
    }
  }
}
