Clear-Host

#Step 1: Build SQL Docker:
Set-Location "$PSScriptRoot\MSSQL-Docker"

# change this tag to be the same version as your OS in the dockerfile. very important!
docker build -t ss-mssql:angus .

#Step 2: Build SSRS Docker:
Set-Location "$PSScriptRoot\SSRS-Docker"

docker build -t ms-ssrs:angus .

#Step 3: Run SSRS Docker

docker run -d --restart always -p 1433:1433 -p 80:80 -v C:/temp/:C:/temp/ -e sa_password=Qwerty12345! -e ACCEPT_EULA=Y -e ssrs_user=SSRSAdmin -e ssrs_password=Qwerty12345! --memory 6048mb ms-ssrs:angus

#Go to localhost/reports to see ssrs

docker run -d -p 1433:1433 -v C:/temp/:C:/temp/ -e sa_password=Qwerty12345! -e ACCEPT_EULA=Y -e attach_dbs="" ss-mssql:angus