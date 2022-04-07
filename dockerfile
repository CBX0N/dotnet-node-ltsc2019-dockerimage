# escape=`
ARG REPO=mcr.microsoft.com/dotnet/framework/runtime
FROM $REPO:4.8-20220210-windowsservercore-ltsc2019

# Create Install Files
RUN mkdir c:\localVSlayout `
  && mkdir "%ProgramFiles%\NuGet\latest" `
  && mkdir c:\installFiles
COPY localVSlayout c:\localVSlayout\
COPY installFiles C:\installFiles

# Install NuGet CLI

RUN powershell.exe -command "Move-Item c:\installFiles\nuget.exe $env:programfiles\NuGet\nuget.exe"
RUN mklink "%ProgramFiles%\NuGet\latest\nuget.exe" "%ProgramFiles%\NuGet\nuget.exe"

# Install VS_BuildTools + Cleanup Once Complete
RUN cmd /C c:\localVSlayout\vs_BuildTools.exe ^`
--add Microsoft.VisualStudio.Component.Roslyn.Compiler ^`
--add Microsoft.Component.MSBuild ^`
--add Microsoft.VisualStudio.Component.CoreBuildTools ^`
--add Microsoft.VisualStudio.Workload.MSBuildTools ^`
--add Microsoft.VisualStudio.Component.Windows10SDK ^`
--add Microsoft.VisualStudio.Component.VC.CoreBuildTools ^`
--add Microsoft.VisualStudio.Component.VC.Redist.14.Latest ^`
--add Microsoft.Net.Component.4.8.SDK ^`
--add Microsoft.VisualStudio.Component.TextTemplating ^`
--add Microsoft.VisualStudio.Component.VC.CoreIde ^`
--add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core ^`
--add Microsoft.VisualStudio.Workload.VCTools ^`
--add Microsoft.VisualStudio.Component.NuGet.BuildTools ^`
--add Microsoft.VisualStudio.Web.BuildTools.ComponentGroup ^`
--add Microsoft.VisualStudio.Component.TypeScript.TSServer ^`
--add Microsoft.NetCore.Component.Runtime.6.0 ^`
--add Microsoft.NetCore.Component.SDK ^`
--add Microsoft.Component.ClickOnce.MSBuild ^`
--add Microsoft.VisualStudio.Component.WebDeploy ^`
--add Microsoft.VisualStudio.Component.Node.Build ^`
--add Microsoft.VisualStudio.Workload.NodeBuildTools ^`
--add Microsoft.NetCore.Component.Runtime.3.1 ^`
--add Microsoft.NetCore.Component.Runtime.5.0 ^`
 --quiet --norestart --wait ` 
 && rmdir c:\localVSlayout /Q /S

ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]