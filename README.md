FIITS — Forensic Investigation & IT Security Toolkit

A collection of PowerShell scripts for Windows-based forensic investigation,
system monitoring, and security analysis. Built for SOC and IT Security environments.



Scripts Included

Script Purpose 

Event_log_analysis.ps1 //Analyzes Windows Event Logs to detect suspicious login attempts, errors, and security events
FIM_in_server.ps1 //File Integrity Monitoring — detects unauthorized file changes on a server
file_monitoring.ps1 //Real-time file system monitoring for detecting additions, deletions, and modifications 
Process_Analysis.ps1 //Analyzes running processes to identify suspicious or unauthorized activity 
Task_sheduler_analysis.ps1 //Audits Windows Task Scheduler for suspicious or unauthorized scheduled tasks 
Deleted_Scheduled_task_analysis.ps1 //Detects and logs deleted scheduled tasks — useful for threat hunting 
network_traffic_analysis.ps1  //Monitors active network connections and flags unusual traffic patterns 
threatning process.ps1  //Identifies and flags potentially threatening processes running on the system 



Tech Stack

Language: PowerShell
Platform: Windows Server / Windows OS
Use Case:SOC Analysis · Forensic Investigation · IT Security Monitoring · Threat Hunting

How to Run

1. Open PowerShell as Administrator
2. Navigate to the script folder:
powershell
cd path\to\FIITS
3. Run any script:
```powershell
   .\Event_log_analysis.ps1
   .\FIM_in_server.ps1
   .\Process_Analysis.ps1

Note:Some scripts require Administrator privileges to access system logs and processes.


Use Cases

SOC Analysts — Monitor and investigate suspicious system activity
System Administrators — Detect unauthorized changes and processes
Forensic Investigators — Collect evidence from Windows event logs and file systems
Threat Hunters — Identify persistence mechanisms via scheduled tasks


Author

Elavarasu E
M.Sc. Cyber Security | C-DAC HPC-AI Chennai
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/elavarasu-e-289745286)
