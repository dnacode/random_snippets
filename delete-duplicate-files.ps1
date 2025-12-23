# Removes any duplicate files example File_xyz.txt, File_xyz(1).txt, File_xyz(7).txt

$ '"C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Command '"'"'$files = Get-ChildItem -Recurse -File "C:'"'"'"\\Users\\vinay\\Pictures\";
"'"'"'$pattern = '"'"'"'"'"' \\(\\d+\\)"'"'"'$| - Copy( '"'"'"\\(\\d+\\))?"'"'"'$'"'"'"'"'"';
"'"'"'$groups = $files | Group-Object { ($_.BaseName -replace $pattern,'"'"'"'"''"') + "'"'"'$_.Extension.ToLower() };
$toDelete = foreach ($g in $groups) {
    if ($g.Count -lt 2) { continue }
    $base = $g.Group | Where-Object { $_.BaseName -notmatch $pattern } | Sort-Object FullName | Select-Object -First 1
    $g.Group | Where-Object { $_ -ne $base -and $_.BaseName -match $pattern }
}
$toDelete | Remove-Item -Force'"'"
