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

# Create Install Files
RUN mkdir c:\localVSlayout `
  && mkdir "%ProgramFiles%\NuGet\latest" `
  && mkdir c:\installfiles
COPY localVSlayout c:\localVSlayout\
COPY installFiles C:\installFiles

# Install NuGet CLI
RUN mv c:\installfiles\nuget.exe "%ProgramFiles%\NuGet\latest\nuget.exe `
    && mklink "%ProgramFiles%\NuGet\latest\nuget.exe" "%ProgramFiles%\NuGet\nuget.exe"

# Install VS_BuildTools + Cleanup Once Complete
RUN `
&& cmd /C c:\localVSlayout\vs_BuildTools.exe ^ `
--add Microsoft.Component.MSBuild ^`
--add Microsoft.VisualStudio.Workload.NodeBuildTools ^`
--add Microsoft.VisualStudio.Workload.VCTools ^`
--quiet --norestart --wait `
&& rmdir c:\localVSlayout /Q /S

ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]