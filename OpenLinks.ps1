# Define the path to the JSON file (same directory as this script)
$jsonPath = Join-Path $PSScriptRoot "links.json"

# Create the JSON file if it doesn't exist
if (-not (Test-Path $jsonPath)) {
    @{} | ConvertTo-Json | Set-Content -Path $jsonPath -Encoding UTF8
}

# Load the JSON data
$links = Get-Content $jsonPath -Raw | ConvertFrom-Json

# Print all saved links
Write-Host "`nSaved Links:`n"
foreach ($key in $links.PSObject.Properties.Name) {
    Write-Host "$key : $($links.$key)"
}

# Ask for input
Write-Host "`nEnter the name of the link to open:"
$name = Read-Host

# Open the URL if it exists
if ($links.PSObject.Properties.Name -contains $name) {
    Start-Process $links.$name
} else {
    Write-Host "❌ No link found for '$name'"
}
