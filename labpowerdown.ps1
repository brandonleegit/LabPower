## Import PowerCLI Module

import-module VMware.PowerCLI

## Connect to lab VCSA

connect-viserver vcsa.cloud.local -user administrator@vsphere.local -password password

## Get VMs in the running state

get-vmhost esx6.cloud.local | get-vm | where-object {$_.Powerstate -eq "PoweredOn"} | select -expandproperty Name | sort | out-file runningvms.txt

## Variables

$runningvms = get-content runningvms.txt

## Shutdown or suspend running VMs

ForEach ($runningvm in $runningvms) {

get-vm $runningvm | Suspend-VM -confirm:$false

}

## Use IPMI to shutdown the VM host

& 'c:\Program Files\Supermicro\IPMI\SMCIPMITool.exe' 10.3.33.116 ADMIN 'password' ipmi power softshutdown


## Send email

send-mailmessage -from "shutdownserver@cloud.local" -to "Pushover <pushover@mailrise.xyz>" -subject "ESX6 is shutdown" -body "ESX6 host has been gracefully powered down" -smtpserver 10.1.149.19 -port 8025