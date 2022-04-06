$gitlocation = "C:\Users\boonc\Documents\GitHub\.NET-VS_BuildTools_Docker_Container"
$localVSlayout = $gitlocation + "\localVSlayout\"
set-location $gitlocation
remove-item localVSlayout -Recurse
Remove-Item c:\localVSlayout -Recurse
mkdir localVSlayout  -ErrorAction SilentlyContinue
mkdir c:\localVSlayout  -ErrorAction SilentlyContinue

c:\users\boonc\vs_BuildTools.exe --layout c:\localVSlayout `
--add Microsoft.Component.MSBuild `
--add Microsoft.VisualStudio.Workload.NodeBuildTools `
--add Microsoft.VisualStudio.Workload.VCTools `
--lang en-US

write-host "VS Build tools Starting."
Start-Sleep -Seconds 20

try{
    $proc = Get-Process -Name vs_layout -ErrorAction SilentlyContinue
    while($proc -ne $null){
        Start-Sleep -Seconds 10
        write-host "----- Checking Status -----"
        $proc = Get-Process -Name vs_layout
        write-host "----- Status: Running -----"
    }
    write-host "----- Status: Complete -----"
    write-host "----- Starting Copy -----"
    copy-item -Recurse c:\localVSlayout\* $localVSlayout\ -Verbose -Force
    write-host "----- Copy Complete -----"
}
catch{
    write-host "vs_layout failed to start"}