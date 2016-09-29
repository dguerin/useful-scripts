$nugetUrl = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
$installDirectory ="c:\Jenkins\Nuget"
$nugetFile = "Nuget.exe"

$tempFile = New-TemporaryFile

$startTime = Get-Date    

Write-Host "Checking the latest Nuget.exe " $startTime

try
{
    Invoke-WebRequest -Uri $nugetUrl -OutFile $tempFile

    $path = Join-Path $installDirectory $nugetFile

    $newfileItem = Get-Item $tempFile
    $oldfileItem = Get-Item $path

    if($newFileItem.Length -ne $oldfileItem)
    {
        Write-Host "Updating Nuget.exe to the latest version"

        Move-Item $tempFile $path

        Write-Host "New version of nuget installed"
    }
}
catch
{
    Write-Host "Cannot contact nuget to get latest, using cached version instead"
}

Write-Host "Using locally installed Nuget.exe"

$endTime = Get-Date
Write-Host "Update completed " + @endTime