# escape=`
ARG REPO=mcr.microsoft.com/dotnet/framework/runtime
FROM $REPO:4.8-20220210-windowsservercore-ltsc2019

COPY setupfiles C:\setupfiles

# Install NuGet CLI
RUN mkdir "%ProgramFiles%\NuGet\latest"
RUN powershell.exe -command "Move-Item c:\setupfiles\nuget.exe $env:programfiles\NuGet\nuget.exe"
RUN mklink "%ProgramFiles%\NuGet\latest\nuget.exe" "%ProgramFiles%\NuGet\nuget.exe"

RUN start /w c:\setupfiles\7z2107-x64.exe /S
RUN start c:\setupfiles\python-3.10.0.exe /quiet InstallAllUsers=1 PrependPath=1

# Install VS_BuildTools + Cleanup Once Complete
RUN c:\setupfiles\localVSlayout\vs_BuildTools.exe ^`
    --add Microsoft.Component.MSBuild ^`
    --add Microsoft.VisualStudio.Workload.NodeBuildTools ^`
    --add Microsoft.VisualStudio.Workload.VCTools ^`
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^`
    --quiet --norestart --wait `
    && powershell -Command "if ($err = dir $Env:TEMP -Filter dd_setup_*_errors.log | where Length -gt 0 | Get-Content) { throw $err }" `
    && rmdir c:\setupfiles\localVSlayout /Q /S

RUN set PATH=%PATH%;c:\Program Files\NuGet\latest\ `
    && set PATH=%PATH%;C:\Program Files\7-Zip\ `
    && set PATH=%PATH%;c:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Microsoft\VisualStudio\NodeJs\ `
    && set PATH=%PATH%;c:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\ 

#NPM install node-gyp

ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]