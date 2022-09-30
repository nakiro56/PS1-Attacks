# Powershell-attacks
- Compilation of different techniques that i currently using in my adversary emulation. 
### To download using powershell:
- Run windows powershell as an administrator, enter the commands below:
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
Invoke-WebRequest "Raw-download-link-of-the-file" -OutFile "Destination-Path-of-the-File"
```
- Other usefull powershell starting lines. 
```
#Self-Elevating script
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}
```
Source: [Atomic Red Team](https://github.com/redcanaryco/atomic-red-team)
## Red Team Study Guides
- [Red Teaming/Adversary Simulation Toolkit](https://renatoborbolla.medium.com/red-teaming-adversary-simulation-toolkit-da89b20cb5ea)
- [cybersec-related pdfs](https://github.com/jivoi/offsec_pdfs)
- [MITRE ATT&CK - Adversaries knowledge library](https://attack.mitre.org/)
- [VirusTotal - lookup and share suspiscious stuff](https://www.virustotal.com/)
- [Nishang – PowerShell for penetration testing](https://github.com/samratashok/nishang)
- [Adversary Emulation Library](https://github.com/center-for-threat-informed-defense/adversary_emulation_library)
