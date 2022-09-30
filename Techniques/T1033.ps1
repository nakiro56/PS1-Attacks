#T1033
#Joshua O. Cabauatan

#Test #1 - System Owner/User Discovery
Start-Process -Filepath cmd.exe -ArgumentList '/c "cmd.exe /C whoami"'
Start-Process -Filepath cmd.exe -ArgumentList '/c "wmic useraccount get /ALL"'
Start-Process -Filepath cmd.exe -ArgumentList '/c "quser /SERVER:"#{computer_name}""'
Start-Process -Filepath cmd.exe -ArgumentList '/c "quser"'
Start-Process -Filepath cmd.exe -ArgumentList '/c "qwinsta.exe /server:#{computer_name}"'
Start-Process -Filepath cmd.exe -ArgumentList '/c "qwinsta.exe"'
Start-Process -Filepath cmd.exe -ArgumentList '/c "for /F `tokens=1,2` %i in ("qwinsta /server:#{computer_name} ^| findstr "Active Disc"") do @echo %i | find /v "#" | find /v "console" || echo %j > computers.txt"'
Start-Process -Filepath cmd.exe -ArgumentList '/c "@FOR /F %n in (computers.txt) DO @FOR /F "tokens=1,2" %i in ("qwinsta /server:%n ^| findstr "Active Disc"") do @echo %i | find /v "#" | find /v "console" || echo %j > usernames.txt"'

