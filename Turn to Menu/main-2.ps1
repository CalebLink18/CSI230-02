. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot Functions2.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 logs`n"
$Prompt += "2 - Display last 10 failed logs`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Champlain.com`n"
$Prompt += "5 - Exit"


$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    $TF = choiceCheck($choice)
    if($tf -ne $true) { Write-Host "incorrect input try again"; $choice = 0 }

    #exit
    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    #Display last 10 apache logs
    elseif($choice -eq 1){
        $lastLogs = last10Logs
        Write-Host ($lastLogs | Format-Table | Out-String)
    }

    #Display last 10 failed logins for all users
    elseif($choice -eq 2){
        $failedLogins = failedLogins10
        Write-Host ($failedLogins | Format-Table | Out-String)
    }

    #Display at risk users
    elseif($choice -eq 3){ 
        $failedLoginsAll = failedLoginsAll
        Write-Host ($failedLoginsAll | Format-Table | Out-String)
    }

    #Start chrome and navigate to champlain.edu
    elseif($choice -eq 4){

    $MinecraftIsBetter = Get-Process -Name "chrome.exe"
    if($MinecraftIsBetter) {Start-Process chrome.exe "champlain.edu"}
           
    }
    
    else { Write-Host "thats not a choice ya dumb cunt, try again" }
}
