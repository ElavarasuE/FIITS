# Path to store the threatening process analysis.txt file
$outputFilePath = "C:\Users\elava\Downloads\Powershell\New folder\threatening_process_analysis.txt"

# Function to output process information
Function Output-ThreateningProcessInfo {
    param (
        [string]$processName,
        [int]$processId,
        [string]$executablePath
    )

    # Output process information to console
    Write-Host "Threatening Process Name: $processName"
    Write-Host "Process ID: $processId"
    Write-Host "Executable Path: $executablePath"
    Write-Host "-----------------------------------"

    # Append process information to the text file
    Add-Content -Path $outputFilePath -Value "Threatening Process Name: $processName"
    Add-Content -Path $outputFilePath -Value "Process ID: $processId"
    Add-Content -Path $outputFilePath -Value "Executable Path: $executablePath"
    Add-Content -Path $outputFilePath -Value "-----------------------------------"
}

# Get all running processes
$processes = Get-WmiObject Win32_Process

# Output threatening process information to the console and text file
$threateningProcesses = $processes | Where-Object { $_.ExecutablePath -match "C:\\Windows\\System32\\" }

if ($threateningProcesses) {
    foreach ($process in $threateningProcesses) {
        $processName = $process.Name
        $processId = $process.ProcessId
        $executablePath = $process.ExecutablePath

        # Output threatening process information
        Output-ThreateningProcessInfo -processName $processName -processId $processId -executablePath $executablePath
    }
} else {
    Write-Host "No threatening processes found."
}

Write-Host "Threatening process analysis saved to: $outputFilePath"
