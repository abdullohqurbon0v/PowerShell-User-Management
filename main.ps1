function WriteCsv {

    $csvFolder = "C:\PowerShellTest"
    if (-not (Test-Path $csvFolder)) {
        New-Item -Path $csvFolder -ItemType Directory | Out-Null
    }

    function Add-User {
        param (
            [string]$name,
            [string]$lastname,
            [int]$age,
            [string]$email
        )

        $user = [PSCustomObject]@{
            name     = $name
            lastname = $lastname
            age      = $age
            email    = $email
        }
 
        $csvPath = "$csvFolder\users.csv"

        if (-Not (Test-Path $csvPath)) {
            $user | Export-Csv -Path $csvPath -NoTypeInformation
        }
        else {
            $user | Export-Csv -Path $csvPath -NoTypeInformation -Append
        }
    }

    $name = Read-Host "Ismingizni kiriting"
    $lastname = Read-Host "Familiyangizni kiriting"
    $age = Read-Host "Yoshingizni kiriting"
    $email = Read-Host "Email manzilingizni kiriting"

    Add-User -name $name -lastname $lastname -age $age -email $email

    $cvs = Import-Csv -Path "$csvFolder\users.csv"
    Write-Output "`n--- Barcha foydalanuvchilar ---"
    $cvs
}

function ReadCsv {
    $csvFolder = "C:\PowerShellTest\users.csv"
    if (-not (Test-Path $csvFolder)) {
        Write-Output "Siz hali beri hech nima yozmagan eklansiz"
    } else {
        Write-Output "-----Foydalanuvchilarni malumotlari-----"
        $csv = Import-Csv -Path "C:\PowerShellTest\users.csv"
        $csv
    }
}

Write-Output "1: CVS ga yozilgan malumotlarni ko'rish"
Write-Output "2: CVS ga malumot yo'zish"
Write-Output "3: CVS dan malumot o'zgartirish"
Write-Output "4: CVS dan malumot ochirish"
$input = Read-Host ">"

switch ($input) {
    "1" { ReadCsv }
    "2" { WriteCsv }
    "3" { Write-Output "❌ Hozircha mavjud emas." }
    "4" { Write-Output "❌ Hozircha mavjud emas." }
    default { Write-Output "Noto‘g‘ri tanlov." }
}