# Setting for Target VM
# Set your resourcegroupname and vmname
$rg_name = ""
$target_vm_name = ""

# Setting for E-mail
$SmtpServer = 'smtp.sendgrid.net'
$Port = 587
$UserName = ''
$Password = ''
$MailFrom = ''
$MailTo = ''
$Encode = 'UTF8'
$Subject = 'テストメール from runbook'

#Auto Authentication
$connection = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzureRmAccount -ServicePrincipal -Tenant $connection.TenantID -ApplicationId $connection.ApplicationID -CertificateThumbprint $connection.CertificateThumbprint

#Get VM status
$powerStatus = (Get-AzureRmVM -ResourceGroupName $rg_name -Name $target_vm_name -Status).Statuses.Item(1).Code
$Body = $powerStatus

#Push Email
if($powerStatus -like "*running" ) {
    $pwd = ConvertTo-SecureString -String $Password -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential $UserName,$pwd
    Send-MailMessage -UseSsl -From $MailFrom -To $MailTo -Subject $Subject -Body $Body -SmtpServer $SmtpServer -Port $Port -Credential $cred -Encoding $Encode
}