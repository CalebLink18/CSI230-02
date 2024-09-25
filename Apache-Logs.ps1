# Apache-Logs.ps1 
function Get-VisitorIPs { param ( [string]$PageVisited, [int]$HttpCode, [string]$BrowserName, [string]$LogFilePath ) 
# Initialize an empty array to hold matching IP addresses
$matchingIPs = @() 
# Read the log file and filter based on the parameters
 Get-Content $LogFilePath | ForEach-Object { if ($_ -match "($PageVisited|$BrowserName).* $HttpCode") { if ($_ -match '(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})') { $matchingIPs += $matches[1] } } } 
 # Return unique matching IP addresses 
 return $matchingIPs | Sort-Object -Unique }