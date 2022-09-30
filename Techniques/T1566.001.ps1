#Joshua O. Cabauatan
#Atomic #1 Download Macro-Enabled Phishing Attachment
$url = 'https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1566.001/bin/PhishingAttachment.xlsm'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $url -OutFile $env:TEMP\PhishingAttachment.xlsm