# Define the output file path
$outputFilePath = "C:\Users\elava\Downloads\Powershell\New folder\user_activity_log.txt"

# Construct the XPath filter to retrieve events with Event ID 4720
$xPathFilter = "*[System[EventID=4720]]"

# Retrieve user creation events (Event ID 4720) from the Security log
$userActivityEvents = Get-WinEvent -LogName Security -FilterXPath $xPathFilter -ErrorAction SilentlyContinue

# Check if user activity events were found
if ($userActivityEvents) {
    # Display user activity events in the console
    $userActivityEvents | Format-Table -AutoSize

    # Save user activity events to the output file
    $userActivityEvents | Out-File -FilePath $outputFilePath -Append

    Write-Host "User activity events saved to $outputFilePath." -ForegroundColor Green
} else {
    Write-Host "No user activity events found." -ForegroundColor Yellow
}
