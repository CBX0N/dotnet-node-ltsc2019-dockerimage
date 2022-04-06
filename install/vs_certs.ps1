$certpath = "C:\localVSlayout\certificates"
certutil.exe -addstore -f "Root" "$certpath\manifestRootCertificate.cer"
certutil.exe -addstore -f "Root" "$certpath\certificates\manifestCounterSignRootCertificate.cer"
certutil.exe -addstore -f "Root" "$certpath\certificates\vs_installer_opc.RootCertificate.cer"