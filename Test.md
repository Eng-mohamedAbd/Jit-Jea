# This Test For JEA 
----------------
# Test JEA

# Target folder C:\Program Files\WindowsPowerShell\spooler_admins

# Register session configuration
Register-PSSessionConfiguration -Name Spooler_Admins -Path 'C:\Program Files\WindowsPowerShell\modules\spooler_admins\spooler_conf.pssc'

Restart-Service -Name WinRM -Force

# Test connection
Enter-PSSession -ComputerName vm3.timw.info -ConfigurationName spooler_admins -Credential timw\stacy

Get-Command

Restart-Service -Name Spooler

Restart-Service -Name WinRM

whoami

ping -4 vm2.timw.info

code c:\transcripts\PowerShell_transcript
