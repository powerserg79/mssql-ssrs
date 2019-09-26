# change this tag to be the same as your OS, very important
FROM mcr.microsoft.com/windows/servercore:1809

LABEL maintainer "Perry Skountrianos"

# Download Links:
ENV exe "https://go.microsoft.com/fwlink/?linkid=840945"
ENV box "https://go.microsoft.com/fwlink/?linkid=840944"
ENV test "true"

ENV sa_password="_" \
    attach_dbs="[]" \
    ACCEPT_EULA="_" \
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# make install files accessible
WORKDIR /

RUN Invoke-WebRequest -Uri $env:box -OutFile SQL.box
RUN Invoke-WebRequest -Uri $env:exe -OutFile SQL.exe
RUN Start-Process -Wait -FilePath .\SQL.exe -ArgumentList /qs, /x:setup
RUN .\setup\setup.exe /q /ACTION=Install /INSTANCENAME=MSSQLSERVER /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\NETWORK SERVICE' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=1 /IACCEPTSQLSERVERLICENSETERMS
# RUN Remove-Item -Recurse -Force SQL.exe, SQL.box, setup

RUN stop-service MSSQLSERVER ; \
    set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; \
    set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; \
    set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.MSSQLSERVER\mssqlserver\' -name LoginMode -value 2 ;

COPY start.ps1 /

HEALTHCHECK CMD [ "sqlcmd", "-Q", "select 1" ]

CMD .\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose