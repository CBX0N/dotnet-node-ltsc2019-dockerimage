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
    --add Microsoft.VisualStudio.Component.Windows10SDK.19041 ^`
    --quiet --norestart --wait `
    && powershell -Command "if ($err = dir $Env:TEMP -Filter dd_setup_*_errors.log | where Length -gt 0 | Get-Content) { throw $err }" `
    && rmdir c:\setupfiles\localVSlayout /Q /S

SHELL ["powershell", "-command"]

RUN setx /M PATH $(${env:path} +\";${Env:programfiles(x86)}\Microsoft Visual Studio\2022\BuildTools\MSBuild\Microsoft\VisualStudio\NodeJs\")
RUN setx /M PATH $(${env:path} +\";${Env:programfiles(x86)}\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\")
RUN setx /M PATH $(${env:path} +\";${Env:programfiles}\7-Zip\")
RUN setx /M PATH $(${env:path} +\";${Env:programfiles}\NuGet\latest\")
RUN setx /M VCINSTALLDIR C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Microsoft\VC\v170

#RUN NPM install node-gyp

ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]