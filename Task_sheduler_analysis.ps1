# Define the output file path
$outputFilePath = "C:\Users\elava\Downloads\Powershell\New folder\scheduled_tasks.txt"

# Get all scheduled tasks
$scheduledTasks = Get-ScheduledTask

# Define keywords that may indicate suspiciousness in task names or actions
$suspiciousKeywords = @("virus", "malware", "ransomware", "exploit", "payload")

# Filter scheduled tasks with suspicious keywords
$suspiciousTasks = $scheduledTasks | Where-Object {
    $taskNameContainsKeyword = $false
    $actionContainsKeyword = $false
    
    # Check if task name contains suspicious keywords
    foreach ($keyword in $suspiciousKeywords) {
        if ($_.TaskName -like "*$keyword*") {
            $taskNameContainsKeyword = $true
            break
        }
    }
    
    # Check if action contains suspicious keywords
    foreach ($keyword in $suspiciousKeywords) {
        if ($_.Actions.Execute -like "*$keyword*") {
            $actionContainsKeyword = $true
            break
        }
    }
    
    # Return true if either task name or action contains suspicious keywords
    $taskNameContainsKeyword -or $actionContainsKeyword
}

# Check if suspicious tasks were found
if ($suspiciousTasks) {
    # Display suspicious tasks in the console
    $suspiciousTasks | Format-Table -AutoSize

    # Save suspicious tasks to the output file
    $suspiciousTasks | Out-File -FilePath $outputFilePath -Append

    Write-Host "Suspicious scheduled tasks saved to $outputFilePath." -ForegroundColor Green
} else {
    Write-Host "No suspicious scheduled tasks found." -ForegroundColor Yellow
}
