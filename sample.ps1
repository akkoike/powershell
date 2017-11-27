# Program of restarting VM
# update 2016/12/30

###########################################################################################
# please set your Id from AAD app(See azure portal)
$keyId_from_aadapp = ""
$web_uri_from_aadapp = ""
$tenant_id_from_aad = ""
# please set your ResourceGroup Name and target VM name
$rg_name = ""
$target_vm_name = ""

###########################################################################################

# auto login for ARM
$secpasswd = ConvertTo-SecureString $keyId_from_aadapp -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ($web_uri_from_aadapp, $secpasswd)
Login-AzureRmAccount -ServicePrincipal -Tenant $tenant_id_from_aadapp -Credential $mycreds

# vm status
$powerStatus = (Get-AzureRmVM -ResourceGroupName $rg_name -Name $target_vm_name -Status).Statuses.Item(1).Code

# execute restart or not
# 'PowerState/deallocated'
# 'PowerState/running'

#  if vm status is PowerState/deallocated , execute start vm
if($powerStatus -like "*running" ) {
    #Restart-AzureRmVM -ResourceGroupName $rg_name -Name $target_vm_name
} else {
    Start-AzureRmVM -ResourceGroupName $rg_name -Name $target_vm_name
}

>


