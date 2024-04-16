# Define the output file path
$outputFilePath = "C:\Users\elava\Downloads\Powershell\New folder\deleted_tasks_log.txt"

# Define the Event IDs for scheduled task creation and update
$eventIDs = @(4698, 4702)

# Try to retrieve event logs for scheduled tasks
try {
    $deletedTaskEvents = Get-WinEvent -LogName Security -FilterXPath "*[System[(EventID=$($eventIDs -join ' or '))]]" -ErrorAction Stop
} catch {
    Write-Host "Error occurred while retrieving event logs for deleted scheduled tasks: $_" -ForegroundColor Red
}

# Check if deleted task events were found
if ($deletedTaskEvents) {
    # Display deleted task events in the console
    $deletedTaskEvents | Format-Table -AutoSize

    # Save deleted task events to the output file
    $deletedTaskEvents | Out-File -FilePath $outputFilePath -Append

    Write-Host "Deleted scheduled task events saved to $outputFilePath." -ForegroundColor Green
} else {
    Write-Host "No deleted scheduled task events found." -ForegroundColor Yellow
}
