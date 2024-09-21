@description('Name of the Local Network Gateway')
param lgwName string

@description('Location where the Local Network Gateway will be deployed')
param lgwRegion string

@description('The public IP address of the local VPN device')
param lgwIpAddress string

@description('Address spaces of the local network in CIDR format, e.g., 10.0.0.0/24')
param lgwAddressSpaces array

@description('Tags to apply to the Local Network Gateway resource')
param lgwTags object = {}

resource localNetworkGateway 'Microsoft.Network/localNetworkGateways@2023-05-01' = {
  name: lgwName
  location: lgwRegion
  properties: {
    localNetworkAddressSpace: {
      addressPrefixes: lgwAddressSpaces
    }
    gatewayIpAddress: lgwIpAddress
  }
  tags: lgwTags
}

output lgwResourceId string = localNetworkGateway.id
