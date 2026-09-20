# AZ-900 Project 1 Commands

Prepared by Dean Lashway

This file lists the commands used during AZ-900 Project 1. 

## Azure CLI

Lists all resources in the Project 1 resource group.

```bash
az resource list --resource-group rg-az900-project1 --output table
```

Displays the custom security rules in the VM's network security group.

```bash
az network nsg rule list --resource-group rg-az900-project1 --nsg-name "<YOUR-VM-NSG-NAME>" --query "[].{Name:name,Priority:priority,Source:sourceAddressPrefix,Port:destinationPortRange,Access:access}" --output table
```

The RDP rule should use port `3389`, allow access, and show one trusted source ending in `/32`. Do not publish the real source IP address.

## Azure PowerShell

Lists the name, type, and location of every resource in the Project 1 resource group.

```powershell
Get-AzResource -ResourceGroupName 'rg-az900-project1' | Select-Object Name, ResourceType, Location | Format-Table
```

Displays the custom security rules in the VM's network security group.

```powershell
Get-AzNetworkSecurityGroup -ResourceGroupName 'rg-az900-project1' -Name '<YOUR-VM-NSG-NAME>' | Select-Object -ExpandProperty SecurityRules | Select-Object Name, Priority, Access, SourceAddressPrefix, DestinationPortRange | Format-Table
```

## Bicep file setup

Creates the folder used for the Bicep file.

```bash
mkdir -p az900-project1-bicep
```

Moves Cloud Shell into the Bicep folder.

```bash
cd az900-project1-bicep
```

Creates or opens the `main.bicep` file in the Cloud Shell editor.

```bash
code main.bicep
```

Lists the files in the current folder so you can confirm that `main.bicep` exists.

```bash
ls
```

Displays the contents of `main.bicep` in Cloud Shell.

```bash
cat main.bicep
```

Displays the installed Bicep version.

```bash
az bicep version
```

## Bicep deployment

Checks `main.bicep` for deployment errors without creating the NSG.

```bash
az deployment group validate --resource-group rg-az900-project1 --template-file main.bicep
```

Previews the changes Azure plans to make without applying them.

```bash
az deployment group what-if --resource-group rg-az900-project1 --template-file main.bicep
```

Deploys the NSG defined in `main.bicep`.

```bash
az deployment group create --resource-group rg-az900-project1 --template-file main.bicep
```

Displays the provisioning status of the resource-group deployments.

```bash
az deployment group list --resource-group rg-az900-project1 --query "[].{Deployment:name,Status:properties.provisioningState}" --output table
```

Confirms the name, region, and status of the Bicep demonstration NSG.

```bash
az network nsg show --resource-group rg-az900-project1 --name nsg-az900-iac --query "{Name:name,Location:location,Status:provisioningState}" --output table
```

The final command should show:

- Name: `nsg-az900-iac`
- Location: `northcentralus`
- Status: `Succeeded`

The demonstration NSG was not attached to the Windows Server VM.


