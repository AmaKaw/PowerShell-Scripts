$computerName = $env:COMPUTERNAME
$currentDate = Get-Date -Format "yyyy-MM-dd"
$outputFileName = "$computerName-Update_History-$currentDate.txt"
$userDesktopPath = [Environment]::GetFolderPath("Desktop")
$outputFilePath = Join-Path -Path $userDesktopPath -ChildPath $outputFileName

$updates = Get-WmiObject -Class Win32_QuickFixEngineering | Sort-Object -Property InstalledOn -Descending

foreach ($update in $updates) {
    $updateDate = Get-Date $update.InstalledOn -Format "yyyy-MM-dd"
    $updateName = $update.Description
    $updateKB = $update.HotFixID
    $updateInfo = "Installed On: $updateDate`r`nUpdate Name: $updateName`r`nUpdate KB: $updateKB`r`n----------------------------------------------------`r`n"
    Add-Content -Path $outputFilePath -Value $updateInfo
}