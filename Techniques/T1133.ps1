#Joshua O. Cabauatan
#Atomic Test #1 - Running Chrome VPN Extensions via the Registry 2 vpn extension

$extList = "fdcgdnkidjaadafnichfpabhfomcebme"
foreach ($extension in $extList) {
  New-Item -Path HKLM:\Software\Wow6432Node\Google\Chrome\Extensions\$extension -Force
  New-ItemProperty -Path "HKLM:\Software\Wow6432Node\Google\Chrome\Extensions\$extension" -Name "update_url" -Value "https://clients2.google.com/service/update2/crx" -PropertyType "String" -Force}
Start chrome
Start-Sleep -Seconds 30
Stop-Process -Name "chrome"
