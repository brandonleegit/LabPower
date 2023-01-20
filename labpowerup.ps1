## Import PowerCLI Module

import-module VMware.PowerCLI

## Connect to lab VCSA

connect-viserver vcsa.cloud.local -user administrator@vsphere.local -password password

## Variables

$runningvms = get-content runningvms.txt


## Power on the Server

& 'c:\Program Files\Supermicro\IPMI\SMCIPMITool.exe' 10.3.33.116 ADMIN '$password' ipmi power up

start-sleep -Seconds 300


## Start your VMs

$poweredonvms = get-content runningvms.txt

foreach ($poweredonvm in $poweredonvms) {
    
  Start-VM -vm $poweredonvm
  Start-Sleep -s 10

    }


## Send email

send-mailmessage -from "shutdownserver@cloud.local" -to "Pushover <pushover@mailrise.xyz>" -subject "ESX6 is powered on" -body "ESX6 host has been gracefully powered on" -smtpserver 10.1.149.19 -port 8025

















