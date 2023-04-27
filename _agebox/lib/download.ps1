$baseUrl="https://github.com/slok/agebox/releases"

# Extract out latest version
$latestRelease = Invoke-WebRequest "$baseUrl/latest" -Headers @{"Accept"="application/json"}
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.tag_name

# Download latest binaries
Invoke-WebRequest -Uri "$baseUrl/download/$latestVersion/agebox-darwin-amd64" -OutFile .\agebox-darwin-amd64
Invoke-WebRequest -Uri "$baseUrl/download/$latestVersion/agebox-darwin-arm64" -OutFile .\agebox-darwin-arm64
Invoke-WebRequest -Uri "$baseUrl/download/$latestVersion/agebox-linux-amd64" -OutFile .\agebox-linux-amd64
Invoke-WebRequest -Uri "$baseUrl/download/$latestVersion/agebox-linux-arm64" -OutFile .\agebox-linux-arm64
Invoke-WebRequest -Uri "$baseUrl/download/$latestVersion/agebox-linux-arm-v7" -OutFile .\agebox-linux-arm-v7
Invoke-WebRequest -Uri "$baseUrl/download/$latestVersion/agebox-windows-amd64.exe" -OutFile .\agebox-windows-amd64.exe

# Output latest version to file
$latestVersion | Out-File .\_VERSION