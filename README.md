# LabPower Script
Automated power off and power on of lab environments and the physical hardware

## Purpose

Due to skyrocketing energy prices, running a home lab with many power hungry servers can be expensive over time. This is a simple power up and power down script that works with Supermicro SMCIPMITool to manage the power of Supermicro servers after gracefully shutting down or suspending virtual machines running in VMware ESXi. 

## Installation

Clone the repo down and edit the passwords in the PS1 files to connect to your vSphere environment and your out-of-band management
