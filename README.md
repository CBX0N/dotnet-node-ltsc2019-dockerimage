# dotnet-node-ltsc2019-dockerimage

Creates an Offline LTSC 2019 docker image with: 
Nuget 6.0 
Visual Studio Build Tools:
  MSBuildTools
  NODE.js
  VCTools
  
Steps to run: 

1. Download vs_buildtools
2. Run .\Build Tools - localVSlayout.ps1
3. Run 'docker build --pull --rm -f "dockerfile" -t dotnet4.8_vsbuild:v2 "." -m 10g'


File path of node.js:
c:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Microsoft\VisualStudio\NodeJs
