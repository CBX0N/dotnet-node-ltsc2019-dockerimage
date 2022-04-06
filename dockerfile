# escape=`
ARG REPO=mcr.microsoft.com/dotnet/framework/runtime
FROM $REPO:4.8-20220210-windowsservercore-ltsc2019

ENV `
    # Do not generate certificate
    DOTNET_GENERATE_ASPNET_CERTIFICATE=false `
    # NuGet version to install
    NUGET_VERSION=6.0.0 `
    # Install location of Roslyn
    ROSLYN_COMPILER_LOCATION="C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\Roslyn"

# Install NuGet CLI
RUN mkdir "%ProgramFiles%\NuGet\latest" `
    && curl -fSLo "%ProgramFiles%\NuGet\nuget.exe" https://dist.nuget.org/win-x86-commandline/v%NUGET_VERSION%/nuget.exe `
    && mklink "%ProgramFiles%\NuGet\latest\nuget.exe" "%ProgramFiles%\NuGet\nuget.exe"

RUN mkdir c:\localVSlayout
COPY localVSlayout c:\localVSlayout\

RUN cmd /C c:\localVSlayout\vs_BuildTools.exe ^ `
--add Microsoft.Component.MSBuild ^`
--add Microsoft.VisualStudio.Workload.NodeBuildTools ^`
--add Microsoft.VisualStudio.Workload.VCTools ^`
--quiet --norestart --wait

RUN rmdir c:\localVSlayout /Q /S

#ENTRYPOINT [ "ping", "-t", "localhost"]
ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
