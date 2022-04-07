# escape=`
ARG REPO=mcr.microsoft.com/dotnet/framework/runtime
FROM $REPO:4.8-20220210-windowsservercore-ltsc2019

COPY setupfiles C:\setupfiles

# Install NuGet CLI

RUN powershell.exe -command "Move-Item c:\setupfiles\nuget.exe $env:programfiles\NuGet\nuget.exe"
RUN mklink "%ProgramFiles%\NuGet\latest\nuget.exe" "%ProgramFiles%\NuGet\nuget.exe"

# Install VS_BuildTools + Cleanup Once Complete
RUN cmd /C c:\setupfiles\localVSlayout\vs_BuildTools.exe ^`
  --add Microsoft.Component.MSBuild ^`
  --add Microsoft.VisualStudio.Workload.NodeBuildTools ^`
  --add Microsoft.VisualStudio.Workload.VCTools ^`
  --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^`
  --quiet --norestart --wait 

#RUN rmdir c:\setupfiles /Q /S
ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]