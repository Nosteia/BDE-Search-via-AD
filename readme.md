# BDE Finder

This PowerShell script will scan all devices in an OU, and break them down into three categories.
skipped: The machine is not reachable or not responding to ping requests.  
unencrypted: This means the script found the BitLocker ProtectionStatus to be equal to 0.  
encrypted: This means the script found the BitLocker ProtectionStatus to not be equal to 0.  