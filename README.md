# dotnet-node-ltsc2019-dockerimage

Creates an Offline LTSC 2019 docker image with: 
Nuget 6.0.0 
Visual Studio Build Tools Workloads:
  Microsoft.Component.MSBuild
  Microsoft.VisualStudio.Workload.NodeBuildTools
  Microsoft.VisualStudio.Workload.VCTools
  
Steps to run: 

1. Run .\Gather_VS_buildTools.ps1 - This creates all directories and files need to install VS_BuildTools 2022 Offline. Also pulls EXE from Microsoft 
2. Run .\Gather_NuGet.ps1 - This creates all directories and files need to install NuGet 6.0.0 Offline. Also pulls EXE from NuGet 
3. Run 'docker build --pull --rm -f "dockerfile" -t dotnet4.8_vsbuild:latest "." -m 10g'

Usefull paths for checking correctly built:
NODEJS VS Workload: c:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Microsoft\VisualStudio\NodeJs

Currently the VS_BuildTools install take a long time, This will look like it has frozen but it has not. 

