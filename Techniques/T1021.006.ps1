#T1021.006 - Remote Services: Windows Remote Management
#Joshua O. Cabauatan
#Pre-req: Must have Ruby, and Evil-WinRM installed


#Pre-reqCommands:
#Invoke-WebRequest  -OutFile $env:Temp\rubyinstaller-2.7.1-1-x64.exe https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.7.1-1/rubyinstaller-2.7.1-1-x64.exe
#$file1= $env:Temp + "\rubyinstaller-2.7.1-1-x64.exe"
#Start-Process $file1 /S;
#gem install evil-winrm


#Run a self-elevated script
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


#Test #1 - Enable Windows Remote Management
Enable-PSRemoting -Force

#Test #2 - Remote Code Execution with PS Credentials Using Invoke-Command

$SecPassword = ConvertTo-SecureString "test12345" -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential("	$env:USERNAME", $SecPassword)
Invoke-Command -ComputerName "$env:COMPUTERNAME" -Credential $Cred -ScriptBlock {whoami}

#Test #3 - WinRM Access with Evil-WinRM
evil-winrm -i Target -u Domain\Administrator -p P@ssw0rd1


