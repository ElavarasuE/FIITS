# Function to display all files and folders inside the Monitoring_Files directory
Function Display-Files-And-Folders {
    Get-ChildItem -Path "\\192.168.155.100\e" -Recurse
}

# Function to calculate the hash of a file
Function Calculate-File-Hash {
    param (
        [string]$FilePath
    )

    # Calculate the hash of the file using SHA256 algorithm
    $hashAlgorithm = [System.Security.Cryptography.SHA256]::Create()
    $fileStream = [System.IO.File]::OpenRead($FilePath)
    $fileHash = [System.BitConverter]::ToString($hashAlgorithm.ComputeHash($fileStream))
    $fileStream.Close()

    return $fileHash.Replace("-", "").ToLower()
}

# Function to register a new file in the central log
Function Register-NewFile {
    param (
        [string]$filePath,
        [string]$action
    )

    # Get the current date and time
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Append the file information to the central log file
    Add-Content -Path $centralLogFile -Value "$timestamp - ${action}: ${filePath}"
}

# Function to monitor for changes in files and folders and log them to CentralLog
Function CentralLog {
    # Clear the baseline.txt file
    Clear-Content -Path .\baseline.txt

    # List all files and folders inside the Monitoring_Files directory
    Display-Files-And-Folders

    # Initialize hash table to store file hashes
    $fileHashes = @{}

    # Populate the initial file hashes
    $files = Get-ChildItem -Path "\\192.168.155.100\e" -File -Recurse
    foreach ($file in $files) {
        $fileHashes[$file.FullName] = Calculate-File-Hash $file.FullName
    }

    # Main monitoring loop
    while ($true) {
        # Check for file modifications, deletions, and creations
        $files = Get-ChildItem -Path "\\192.168.155.100\e" -File -Recurse
        foreach ($file in $files) {
            $currentHash = Calculate-File-Hash $file.FullName

            if ($fileHashes.ContainsKey($file.FullName)) {
                # File exists in the initial state
                if ($currentHash -ne $fileHashes[$file.FullName]) {
                    # File has been modified
                    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                    Write-Host "$timestamp - File '$($file.FullName)' has been modified!" -ForegroundColor Yellow
                    Register-NewFile -filePath $file.FullName -action "Modified"
                    $fileHashes[$file.FullName] = $currentHash
                }
            } else {
                # File is new (not present in the initial state)
                $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                Write-Host "$timestamp - File '$($file.FullName)' has been created!" -ForegroundColor Green
                Register-NewFile -filePath $file.FullName -action "Created"
                $fileHashes[$file.FullName] = $currentHash
            }
        }

        # Check for deleted files
        $fileHashesKeysCopy = @($fileHashes.Keys) # Make a copy of the keys
        foreach ($filePath in $fileHashesKeysCopy) {
            if (!(Test-Path $filePath)) {
                # File does not exist anymore (deleted)
                $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                Write-Host "$timestamp - File '$($filePath)' has been deleted!" -ForegroundColor Red
                Register-NewFile -filePath $filePath -action "Deleted"
                $fileHashes.Remove($filePath)
            }
        }

        # Wait for a few seconds before repeating the loop
        Start-Sleep -Seconds 5
    }
}

# Define the path for the central log file
$centralLogFile = "C:\Users\elava\Downloads\Powershell\results\CentralLog.txt"

# Call the function to start monitoring and logging to CentralLog
CentralLog
