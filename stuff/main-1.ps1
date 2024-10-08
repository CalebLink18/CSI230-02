. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot Functions.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"
$Prompt += "10 - List at Risk Users`n"



$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }

    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        # Checks if user a exists. 
        # If user exists, returns true, else returns false
        $bool = checkUser($name)

        # If false is returned, continue with the rest of the function
        # If true is returned, do not continue and inform the user
        if($bool -eq $true){ Write-Host "already exists, try again"; continue}

      
        # If false is returned, do not continue and inform the user
        # If true is returned, continue with the rest of the function
        $boolean = checkPassword
        if($boolean -eq $false){ Write-Host "invalid password, try again"; continue}

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }

    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # Check the given username with the checkUser function.
        # Checks if user a exists. 
        # If user exists, returns true, else returns false
        $bool = checkUser($name)

        # If false is returned, continue with the rest of the function
        # If true is returned, do not continue and inform the user
        if($bool -eq $false){ Write-Host "doesn't exist, try again"; continue}

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }

    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # Check the given username with the checkUser function.
        # Checks if user a exists. 
        # If user exists, returns true, else returns false
        $bool = checkUser($name)

        # If false is returned, continue with the rest of the function
        # If true is returned, do not continue and inform the user
        if($bool -eq $false){ Write-Host "doesn't exists, try again"; continue}

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }

    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # Check the given username with the checkUser function.
        # Checks if user a exists. 
        # If user exists, returns true, else returns false
        $bool = checkUser($name)

        # If false is returned, continue with the rest of the function
        # If true is returned, do not continue and inform the user
        if($bool -eq $false){ Write-Host "doesn't exists, try again"; continue}

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }

    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # Check the given username with the checkUser function.
        # Checks if user a exists. 
        # If user exists, returns true, else returns false
        $bool = checkUser($name)

        # If false is returned, continue with the rest of the function
        # If true is returned, do not continue and inform the user
        if($bool -eq $false){ Write-Host "doesn't exists, try again"; continue}

        $time = Read-Host -Prompt "Please enter how far back you want to look"

        $userLogins = getLogInAndOffs $time
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # Check the given username with the checkUser function.
        # Checks if user a exists. 
        # If user exists, returns true, else returns false
        $bool = checkUser($name)

        # If false is returned, continue with the rest of the function
        # If true is returned, do not continue and inform the user
        if($bool -eq $false){ Write-Host "doesn't exists, try again"; continue}

        $time = Read-Host -Prompt "Please enter how far back you want to look"

        $userLogins = getFailedLogins $time
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    } 

    # Lists all the users with more than 10 failed logins in the last <User Given> days.
    elseif($choice -eq 10){
    
    $time = Read-Host -Prompt "Please enter how far back you want to look"
    $userLogins = getFailedLogins $time

    #Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    write-host "couldnt complete"

    }

    else { Write-Host "thats not a choice ya dumb cunt, try again" }
}
