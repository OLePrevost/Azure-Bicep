param afwpName string

// Rule Collection Group: RuleCollectionGroup-TestingAndTempRules
resource ruleCollectionGroup_1 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-11-01' = {
  name: '${afwpName}/RuleCollectionGroup-TestingAndTempRules'
  dependsOn: []
  properties: {
    priority: 500
    ruleCollections: [
      {
        name: 'RuleCollection-Testing-Network'
        priority: 500
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: []
      }
      {
        name: 'RuleCollection-Testing-Application'
        priority: 515
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: []
      }
      {
        name: 'RuleCollection-Testing-DNAT'
        priority: 530
        ruleCollectionType: 'FirewallPolicyNatRuleCollection'  // Updated
        rules: []
      }
    ]
  }
}

// Rule Collection Group: RuleCollectionGroup-Internal-Network
resource ruleCollectionGroup_2 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-11-01' = {
  name: '${afwpName}/RuleCollectionGroup-Internal-Network'
  dependsOn: [ruleCollectionGroup_1]
  properties: {
    priority: 1000
    ruleCollections: []
  }
}

// Rule Collection Group: RuleCollectionGroup-Outbound-Network
resource ruleCollectionGroup_3 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-11-01' = {
  name: '${afwpName}/RuleCollectionGroup-Outbound-Network'
  dependsOn: [ruleCollectionGroup_2]
  properties: {
    priority: 11000
    ruleCollections: [
      {
        name: 'RuleCollection-AVDShortPath-Allow'
        priority: 11400
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: []
      }
      {
        name: 'RuleCollection-LANToInternet-Allow'
        priority: 11200
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: []
      }
    ]
  }
}

// Rule Collection Group: RuleCollectionGroup-Outbound-Application
resource ruleCollectionGroup_4 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-11-01' = {
  name: '${afwpName}/RuleCollectionGroup-Outbound-Application'
  dependsOn: [ruleCollectionGroup_3]
  properties: {
    priority: 16000
    ruleCollections: [
      {
        name: 'RuleCollection-WebCategories-Explicit-Deny'
        priority: 16500
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: []
      }
      {
        name: 'RuleCollection-WebCategories-Explicit-Allow'
        priority: 17000
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: []
      }
      {
        name: 'RuleCollection-WebCategories-Default-Deny'
        priority: 17500
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: []
      }
      {
        name: 'RuleCollection-WebCategories-Default-Allow'
        priority: 18000
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: []
      }
    ]
  }
}

// Rule Collection Group: RuleCollectionGoup-Inbound-Network
resource ruleCollectionGroup_5 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-11-01' = {
  name: '${afwpName}/RuleCollectionGoup-Inbound-Network'
  dependsOn: [ruleCollectionGroup_4]
  properties: {
    priority: 21000
    ruleCollections: [
      {
        name: 'RuleCollection-AzurePrivateLink-Allow'
        priority: 21500
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'  // Updated
        rules: [
          {
            name: 'AzurePrivateDNSResolver'
            ruleType: 'NetworkRule'
            sourceAddresses: ['168.63.129.16']
            destinationAddresses: ['*']
            destinationPorts: ['53', '80', '32526']
            ipProtocols: ['TCP', 'UDP']
          }
        ]
      }
    ]
  }
}

// Rule Collection Group: RuleCollectionGroup-Inbound-DNAT
resource ruleCollectionGroup_6 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-11-01' = {
  name: '${afwpName}/RuleCollectionGroup-Inbound-DNAT'
  dependsOn: [ruleCollectionGroup_5]
  properties: {
    priority: 31000
    ruleCollections: []
  }
}
