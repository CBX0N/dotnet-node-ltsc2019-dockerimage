$gitlocation = "C:\Users\boonc\Documents\GitHub\.NET-VS_BuildTools_Docker_Container"
$localVSlayout = $gitlocation + "\localVSlayout\"
set-location $gitlocation
mkdir localVSlayout  -ErrorAction SilentlyContinue
mkdir c:\localVSlayout  -ErrorAction SilentlyContinue

c:\users\boonc\vs_BuildTools.exe --layout c:\localVSlayout `
    --add Microsoft.Component.ClickOnce.MSBuild  `
    --add Microsoft.Net.Component.4.8.SDK  `
    --add Microsoft.NetCore.Component.Runtime.3.1  `
    --add Microsoft.NetCore.Component.Runtime.5.0  `
    --add Microsoft.NetCore.Component.Runtime.6.0  `
    --add Microsoft.NetCore.Component.SDK  `
    --add Microsoft.VisualStudio.Component.NuGet.BuildTools  `
    --add Microsoft.VisualStudio.Component.WebDeploy  `
    --add Microsoft.VisualStudio.Web.BuildTools.ComponentGroup  `
    --add Microsoft.VisualStudio.Workload.MSBuildTools `
    --add Microsoft.VisualStudio.Workload.Node `
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