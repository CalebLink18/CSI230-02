. (Join-Path $PSScriptRoot Users.ps1)

function checkUser($User) {

$bool = $false

$userList = Get-LocalUser

for($i=0; $i -lt $userList.length; $i++){

    $temp = $userList[$i]

    if($User -ilike $temp.name){$bool = $true}

}

return $bool

}