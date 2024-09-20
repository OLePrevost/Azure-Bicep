param name string
param location string
param tier string
param tags object
param threatIntelMode string  // e.g., 'AlertOnly', 'Deny'
param enableDnsProxy bool = false  // Option to enable or disable DNS proxy
param idp string

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-11-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      tier: tier  // Only "tier" should be specified here for firewall policies
    }
    threatIntelMode: threatIntelMode
    dnsSettings: {
      enableProxy: enableDnsProxy
    }
    intrusionDetection: {
      mode: idp
  }
}
