. (Join-Path $PSScriptRoot Users.ps1)

function choiceCheck($string) {

if ($string -ne {1-5}) {return $false}

}

function last10Logs() {

$logsNotFormatted = get-content C:\xampp\apache\logs\access.log
$tableRecords = @{}

for ($i=0; $i -lt $logsNotFormatted.Count ;$i++ ){

$words = $logsNotFormatted[$i] -split " ";

                $tableRecords += [PSCustomObject]@{
                           "IP" = $words[0];
                           "Time" = $words[3].Trim('[');
                           "Method" = $words[5].Trim('"');
                           "Page" = $words[6];
                           "Protocol" = $words[7];
                           "Response" = $words[8];
                           "Referrer" = $words[9];
                           "Client" = $words[11..($words. ...)];}

}
return $tableRecords | Where-Object { $_.IP -like "10.*"}

}

function failedLogins10() {
  
  $failedlogins = Get-EventLog security | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }
    }
    $chickenTendies = $failedloginsTable | Select-Object -First 10

    return $chickenTendies
}


function failedLoginsAll() {
  
  $failedlogins = Get-EventLog security | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }
    }
    return $failedloginsTable
}
