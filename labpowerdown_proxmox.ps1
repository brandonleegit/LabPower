
## Import Proxmox PowerShell Module

import-module Corsinvest.ProxmoxVE.Api

## Connect to lab VCSA

connect-pvecluster -hostsandports 10.1.149.74:8006 -credentials root@pam -SkipCertificateCheck

## Get VMs in the running state

get-pvevm | where {$_.Status -eq "Stopped"} select -expandproperty vmid | sort | out-file runningvms.txt

## Variables

$runningvms = get-content runningvms.txt

## Shutdown or suspend running VMs

ForEach ($runningvm in $runningvms) {

get-pvevm $runningvm | Suspend-PveVM -confirm:$false

}

## Use IPMI to shutdown the VM host

& 'c:\Program Files\Supermicro\IPMI\SMCIPMITool.exe' 10.3.33.116 ADMIN 'password' ipmi power softshutdown


## Send email

send-mailmessage -from "shutdownserver@cloud.local" -to "Pushover <pushover@mailrise.xyz>" -subject "ESX6 is shutdown" -body "ESX6 host has been gracefully powered down" -smtpserver 10.1.149.19 -port 8025