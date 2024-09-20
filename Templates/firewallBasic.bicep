@description('Name of the Azure Firewall')
param firewallName string

@description('Location where the Azure Firewall will be deployed')
param location string

@description('The name of the existing Azure Firewall Policy to attach')
param firewallPolicyId string

@description('Public IP address to associate with the Azure Firewall')
param publicIpAddress string

@description('Public Management IP address to associate with the Azure Firewall')
param managementPublicIpAddress string

@description('Virtual Network Name where the Azure Firewall will be deployed')
param virtualNetworkName string

@description('Subnet Name where the Azure Firewall will be deployed')
param subnetName string

@description('SKU tier for the Azure Firewall (Standard or Premium)')
param skuTier string

@description('Tags for the Azure Firewall')
param tags object = {}

resource firewall 'Microsoft.Network/azureFirewalls@2023-05-01' = {
  name: firewallName
  location: location
  tags: tags
  properties: {
    firewallPolicy: {
      id: firewallPolicyId
    }
    ipConfigurations: [
      {
        name: '${firewallName}-ipConfig'
        properties: {
          publicIPAddress: {
            id: publicIpAddress
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
          }
        }
      }
      {
        name: '${firewallName}-managementIpConfig'
        properties: {
          publicIPAddress: {
            id: managementPublicIpAddress
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
          }
        }
      }
    ]
    sku: {
      name: 'AZFW_VNet'
      tier: skuTier
    }
  }
}

output firewallId string = firewall.id
