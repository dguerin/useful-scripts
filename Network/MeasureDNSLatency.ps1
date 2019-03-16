param (
    [Parameter(Mandatory=$true)][string]$hostname,
    [Parameter(Mandatory=$true)][string]$dnsserver,
    [Parameter(Mandatory=$false)][int]$numberoftests = 30
 )

Clear-Host

$totalmeasurement = 0
$i = 1
$values = @(0) * $numberoftests

while ($i -ne $numberoftests+1)
{
    $measurement = (Measure-Command -Expression {Resolve-DnsName $hostname -Server $dnsserver -DnsOnly}).TotalMilliseconds

    $values[$i-1] = $measurement
    Write-Host $i "of " $numberoftests " : " $measurement " ms"
    $totalmeasurement += $measurement

    $i += 1
    Start-Sleep -Seconds 1
}

$totalmeasurement = $totalmeasurement / $numberoftests

$avgCount = $values | Measure-Object -Average | Select-Object Average, Count
ForEach($number in $values) {

    $newNumbers += [Math]::Pow(($number - $avgCount.Average), 2)
}
$stdDev = [math]::Sqrt($($newNumbers / ($avgCount.Count - 1)))
$stdRounded = [math]::Round($stdDev, 3)

Write-Host "DNS Server: "  $dnsserver ", hostname" $hostname". Response time: " $totalmeasurement " ms" " SD: " $stdRounded "+/-ms"