# Path to store the process analysis.txt file
$outputFilePath = "C:\Users\elava\Downloads\Powershell\New folder\process_analysis.txt"

# Get all running processes
$processes = Get-WmiObject Win32_Process

# Output process information to the console and text file
$processes | ForEach-Object {
    $processId = $_.ProcessId
    $processName = $_.Name
    $parentProcessId = $_.ParentProcessId

    # Get parent process information
    $parentProcess = Get-WmiObject Win32_Process -Filter "ProcessId = $parentProcessId" -ErrorAction SilentlyContinue
    if ($parentProcess -eq $null) {
        $parentProcessName = "Not Found"
    } else {
        $parentProcessName = $parentProcess.Name
    }

    # Output process information to console
    Write-Host "Process Name: $processName"
    Write-Host "Process ID: $processId"
    Write-Host "Parent Process Name: $parentProcessName"
    Write-Host "Parent Process ID: $parentProcessId"
    Write-Host "-----------------------------------"

    # Append process information to the text file
    Add-Content -Path $outputFilePath -Value "Process Name: $processName"
    Add-Content -Path $outputFilePath -Value "Process ID: $processId"
    Add-Content -Path $outputFilePath -Value "Parent Process Name: $parentProcessName"
    Add-Content -Path $outputFilePath -Value "Parent Process ID: $parentProcessId"
    Add-Content -Path $outputFilePath -Value "-----------------------------------"
}

Write-Host "Process analysis saved to: $outputFilePath"

