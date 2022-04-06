$gitlocation = Get-Location
$localVSlayout =  $gitlocation.Path + "\localVSlayout\"
$uri = "https://download.visualstudio.microsoft.com/download/pr/3f21c6d5-11da-4876-aa78-a2b2cce30660/93c963cfe8026132ae1567e2917ce60fe7301eb7d6985618010ec31b2c80a184/vs_BuildTools.exe"
set-location $gitlocation.Path

Write-Host "----- Removing Existing VS_BuildTools Install Files -----"
remove-item localVSlayout -Recurse -ErrorAction SilentlyContinue
Remove-Item c:\localVSlayout -Recurse -ErrorAction SilentlyContinue
Write-Host "++++ Done ++++"
Start-sleep -Seconds 1

Write-Host "----- Creating Directories for Offline Install Files -----"
mkdir localVSlayout  -ErrorAction SilentlyContinue
mkdir c:\localVSlayout  -ErrorAction SilentlyContinue
mkdir C:\temp\ -ErrorAction SilentlyContinue
Write-Host "++++ Done ++++"
Start-sleep -Seconds 1

Write-Host "----- Downloading VS_Buildtools EXE -----"
Invoke-WebRequest $uri -OutFile C:\temp\vs_BuildTools.exe
Write-Host "++++ Done ++++"
Start-sleep -Seconds 1

write-host "----- Building Offline Install Files -----"
c:\temp\vs_BuildTools.exe --layout c:\localVSlayout `
--add Microsoft.Component.MSBuild `
--add Microsoft.VisualStudio.Workload.NodeBuildTools `
--add Microsoft.VisualStudio.Workload.VCTools `
--lang en-US
Start-Sleep -Seconds 20

try{
    $proc = Get-Process -Name vs_layout -ErrorAction SilentlyContinue
    while($null -ne $proc){
        Start-Sleep -Seconds 10
        write-host "----- Checking Status -----"
        $proc = Get-Process -Name vs_layout
        write-host "++++ Still Running ++++"
    }
    Write-Host "++++ Done ++++"
    Start-sleep -Seconds 1
    write-host "----- Starting Copy -----"
    copy-item -Recurse c:\localVSlayout\* $localVSlayout\ -Verbose -Force
    write-host "++++ Done ++++"
    Start-Sleep -Seconds 1
}
catch{
    write-host "vs_layout failed to start"}