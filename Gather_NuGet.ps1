$location = Get-Location
$location = $location.Path + "\installFiles"
mkdir $location -ErrorAction SilentlyContinue
$uri = "https://dist.nuget.org/win-x86-commandline/v6.0.0/nuget.exe" 
Invoke-WebRequest -uri $uri -OutFile $location\nuget.exe
