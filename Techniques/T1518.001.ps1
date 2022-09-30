#Joshua O. Cabauatan
#Atomic Test #6 - Security Software Discovery - AV Discovery via WMI
wmic.exe /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName /Format:List
