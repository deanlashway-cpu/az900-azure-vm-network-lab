param location string = 'northcentralus'

resource securityNsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: 'nsg-az900-iac'
  location: location
  tags: {
    Environment: 'Lab'
    Project: 'AZ900-Project1'
    Owner: 'Dean'
    Deployment: 'Bicep'
  }
}

output nsgName string = securityNsg.name