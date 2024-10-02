function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.10/Courses-1.html

$trs=$page.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()
for ($i=1; $i -lt $trs.length; $i++){

    $tds = $trs[$i].getElementsByTagName("td") # <-- probably incorrect

    $times = $tds[5].innerText.split("-") # cannot index into a null array

    $FullTable += [PSCustomObject]@{ # somethings wrong
    
        "Class Code" = $tds[0].innerText; `
        "Title" = $tds[1].innerText; `
        "Days" = $tds[4].innerText; `
        "Time Start" = $times[0]; `
        "Time End" = $times[1]; `
        "Instructor" = $tds[5].innerText; `
        "Location" = $tds[8].innerText ; `

    }

}

return $FullTable

}

function daysTranslator($FullTable){

for ($i=0; $i -lt $FullTable.length; $i++) {

    $days = @()

    if($FullTable[$i].Days -ilike "*M*"){ $days += "Monday" }

    if($FullTable[$i].Days -ilike "*T*" -or $FullTable[$i].Days -ilike "*TU*"){ $days += "Tuesday" }

    if($FullTable[$i].Days -ilike "*W*"){ $days += "Wendsday" }

    if($FullTable[$i].Days -ilike "*TH*"){ $days += "Thursday" }

    if($FullTable[$i].Days -ilike "*F*"){ $days += "Friday" }

    $FullTable[$i].Days = $days

}

return $FullTable

}

$FullTable = gatherClasses
$FullTable = daysTranslator($FullTable)
$FullTable