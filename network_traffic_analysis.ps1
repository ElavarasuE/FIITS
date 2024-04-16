# Define list of known malicious IP addresses
$maliciousIPs = @("1.2.3.4", "5.6.7.8", "10.0.0.1")

# Get current network connections
$networkConnections = Get-NetTCPConnection | Where-Object { $_.State -eq "Established" }

# Define the output file path
$outputFilePath = "C:\Users\elava\Downloads\Powershell\New folder\network_traffic_analyze.txt"

# Open or create the output file
$outFile = New-Object System.IO.StreamWriter($outputFilePath, $true)

# Display and store results for each network connection
foreach ($connection in $networkConnections) {
    $localAddress = $connection.LocalAddress
    $localPort = $connection.LocalPort
    $remoteAddress = $connection.RemoteAddress
    $remotePort = $connection.RemotePort
    $processId = $connection.OwningProcess

    # Get process name associated with the process ID
    $processName = (Get-Process -Id $processId).Name

    # Display the result
    $result = "Local Address: $localAddress, " +
              "Local Port: $localPort, " +
              "Remote Address: $remoteAddress, " +
              "Remote Port: $remotePort, " +
              "Process Name: $processName, " +
              "Process ID: $processId"

    Write-Host $result

    # Check if the remote address is in the list of malicious IP addresses
    if ($maliciousIPs -contains $remoteAddress) {
        $output = "Suspicious connection detected:`n" +
                  "Local Address: $localAddress`n" +
                  "Local Port: $localPort`n" +
                  "Remote Address: $remoteAddress`n" +
                  "Remote Port: $remotePort`n" +
                  "Process Name: $processName`n" +
                  "Process ID: $processId`n" +
                  "-----------------------------------`n"

        # Write the output to the file
        $outFile.WriteLine($output)
    }
}

# Close the output file
$outFile.Close()

Write-Host "Network traffic analysis completed. Results saved to $outputFilePath."
