#T1547.004
#Joshua O. Cabauatan
#Test #2 - Winlogon Userinit Key Persistence - PowerShell
Set-ItemProperty "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\" "Userinit" "Userinit.exe, C:\Windows\System32\cmd.exe" -Force

#Cleanupcommand: Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\" -Name "Userinit" -Force -ErrorAction Ignore