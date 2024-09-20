param pipName string                 // Name of the Public IP
param location string                // Region for the Public IP
param ipVersion string               // IPv4 or IPv6
param sku string                     // Standard or Basic SKU
param zone array                     // Availability zones (can be an empty array if not used)
param tier string                    // Regional or Global tier
param assignment string              // Static or Dynamic IP assignment
param routingPreference string       // Microsoft or Internet routing preference
param ddosProtection bool            // Enable or disable DDoS protection
param tags object                    // Resource tags

resource publicIP 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: pipName
  location: location
  sku: {
    name: sku
    tier: tier
  }
  zones: zone
  properties: {
    publicIPAllocationMethod: assignment
    publicIPAddressVersion: ipVersion
    ddosSettings: {
      protectionMode: ddosProtection ? 'VirtualNetworkInherited' : 'Disabled'
    }
    routingPreference: routingPreference
    idleTimeoutInMinutes: 4  // Optional: Default idle timeout
  }
  tags: tags
}
