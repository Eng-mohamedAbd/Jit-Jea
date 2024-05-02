Connect-AzAccount
Get-AzResourceGroup
Get-AzVM
New-AzResourceGroup -Name TestFromPS -Location eastus

New-AzResourceGroup -Name TestResourceGroup -Location centralus
## Create Virtual network
$frontendSubnet = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "10.0.1.0/24"
$backendSubnet  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "10.0.2.0/24"
New-AzVirtualNetwork -Name DemoVnet2 -ResourceGroupName TestFromPS -Location eastus -AddressPrefix "10.0.0.0/16" -Subnet $frontendSubnet,$backendSubnet
Get-AzVirtualNetwork -Name demovnet -ResourceGroupName TestFromPS

### Create Network Security Group
$rule1 = New-AzNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

$rule2 = New-AzNetworkSecurityRuleConfig -Name web-rule -Description "Allow HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80

$nsg = New-AzNetworkSecurityGroup -ResourceGroupName TestFromPS -Location eastus -Name DemoNSG -SecurityRules $rule1,$rule2

Get-AzNetworkSecurityGroup -ResourceGroupName TestFromPS
###################
New-AzVm -ResourceGroupName TestFromPS -Name DemoVM -Location eastus -Image Ubuntu2204 -Size  -VirtualNetworkName DemoVnet2 -SubnetName $frontendSubnet -SecurityGroupName DemoNSG -PublicIpAddressName DemoPIP

New-AzVm -ResourceGroupName VMFPS -Name TestFromPS -Location 'East US' -Image 'MicrosoftWindowsServer:WindowsServer:2022-datacenter-azure-edition:latest' -VirtualNetworkName 'myVnet' -SubnetName 'mySubnet' -SecurityGroupName 'myNetworkSecurityGroup' -PublicIpAddressName 'myPublicIpAddress' -OpenPorts 80,3389

Stop-AzVM -ResourceGroupName TestFromPS -Name DemoVM
Remove-AzVM -ResourceGroupName TestFromPS -Name DemoVM

Get-AzResource | Format-Table
Get-AzResource -ResourceGroupName testRG | Format-Table
Remove-AzResource -ResourceGroupName TestFromPS -Force
Remove-AzResourceGroup -Name TestFromPS -Force
## 
