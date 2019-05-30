$OU = "AD INFO HERE"
$computers = Get-ADComputer -Filter * -SearchBase $OU | Select-Object Name | Foreach {$_.Name}
$fileDump = "C:\scripts\Dump"

foreach ($computer in $computers)
    {
    $PingResult = Test-Connection -ComputerName $computer -Count 1 -Quiet
		    If($PingResult)
		    {
                $bdeStatus = Get-WmiObject -Class Win32_EncryptableVolume -Namespace "root\cimv2\security\MicrosoftVolumeEncryption" -ComputerName $computer -ErrorAction SilentlyContinue 

                If($bdeStatus.ProtectionStatus -ne 0)
				{
                    Write-Host "$computer is protected."
                    Out-File -append -FilePath $fileDump\encrypted.txt -InputObject $computer
                    }
                    Else
                    {
                    Write-Host "$computer is not protected"
                    Out-File -append -FilePath $fileDump\unencrypted.txt -InputObject $computer
                    }
                    $bdeStatus = $null
            }
            Else
            {
                Write-Host "$computer isn't responding. Skipping..."
                Out-File -append -FilePath $fileDump\skipped.txt -InputObject $computer
            }
    }