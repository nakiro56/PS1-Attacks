#T1021.001 - Remote Services: Remote Desktop Protocol
#Joshua O. Cabauatan

#Test #1 - RDP to DomainController
$Server=$ENV:logonserver.TrimStart("\")
$User = Join-Path $Env:USERDOMAIN $ENV:USERNAME
$Password="1password2!"
cmdkey /generic:TERMSRV/$Server /user:$User /pass:$Password
mstsc /v:$Server
echo "RDP connection established"


#CleanupCommands:
#$p=Tasklist /svc /fi "IMAGENAME eq mstsc.exe" /fo csv | convertfrom-csv
#if(-not ([string]::IsNullOrEmpty($p.PID))) { Stop-Process -Id $p.PID }