$gitlocation = $PSScriptRoot
$localVSlayout =  Join-Path $PSScriptRoot -ChildPath "\localVSlayout\"
Remove-Item -Path $localVSlayout -Recurse

Write-Host "----- Creating Directories for Offline Install Files -----"
New-Item -path $localVSlayout -ItemType Directory
Write-Host "++++ Done ++++"

Write-Host "----- Creating Offline Install Files -----"
cmd /c $gitlocation\vs_BuildTools.exe --layout $localVSlayout `
    --add Microsoft.Component.MSBuild `
    --add Microsoft.VisualStudio.Workload.NodeBuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
    --add Microsoft.VisualStudio.Component.Windows10SDK.19041 `
    --lang en-US
Write-Host "++++ Done ++++"