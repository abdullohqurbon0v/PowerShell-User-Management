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
