#docker pull mcr.microsoft.com/windows/servercore:1809
#docker pull hello-world:nanoserver-1809

#
# BUILD CUSTOM IMAGES
#
Set-Location "$PSScriptRoot\MSSQL-Docker"

# change this tag to be the same version as your OS in the dockerfile. very important!
docker build -t nanoserver-mssql:clean .

#Step 2: Build SSRS Docker:
Set-Location "$PSScriptRoot\SSRS-Docker"

docker build -t nanoserver-ssrs:clean .

Set-Location $PSScriptRoot

#
# CC
#
#sql + ssrs
docker run -d --name cc_sqlssrs --restart always -p 1433:1433 -p 6000:80 -v C:/Containers/cc_sqlssrs/:C:/temp/ -e sa_password=Qwerty12345! -e ACCEPT_EULA=Y -e ssrs_user=SSRSAdmin -e ssrs_password=Qwerty12345! --memory 6048mb nanoserver-ssrs:clean

$IE=new-object -com internetexplorer.application
 $IE.navigate2("http://localhost:6000/reports")
 $IE.visible=$true

 docker run -d --name sms1_sqlssrs --restart always -p 1443:1433 -p 6010:80 -v C:/Containers/sms1_sqlssrs/:C:/temp/ -e sa_password=Qwerty12345! -e ACCEPT_EULA=Y -e ssrs_user=SSRSAdmin -e ssrs_password=Qwerty12345! --memory 6048mb nanoserver-ssrs:clean

 # login with ssrs_user=SSRSAdmin -e ssrs_password=Qwerty12345!
$IE=new-object -com internetexplorer.application
$IE.navigate2("http://localhost:6010/reports")
$IE.visible=$true

docker run -d --name sms2_sqlssrs --restart always -p 1453:1433 -p 6020:80 -v C:/Containers/sms2_sqlssrs/:C:/temp/ -e sa_password=Qwerty12345! -e ACCEPT_EULA=Y -e ssrs_user=SSRSAdmin -e ssrs_password=Qwerty12345! --memory 6048mb nanoserver-ssrs:clean

 # login with ssrs_user=SSRSAdmin -e ssrs_password=Qwerty12345!
 $IE=new-object -com internetexplorer.application
 $IE.navigate2("http://localhost:6020/reports")
 $IE.visible=$true

# rabbitmq
# docker run --name  cc_nanoserver1 hello-world:nanoserver-1809

# # api
# docker run --name  cc_nanoserver2 hello-world:nanoserver-1809

# # migration
# docker run --name  cc_nanoserver3 hello-world:nanoserver-1809

# # angular
# docker run --name  cc_nanoserver4 hello-world:nanoserver-1809

# # topshelf
# docker run --name  cc_nanoserver5 hello-world:nanoserver-1809

# #
# # SMS1
# #
# #sql
# docker run --memory 6048mb --name  sms1_servercore1 mcr.microsoft.com/windows/servercore:1809

# # rabbitmq
# docker run --name  sms1_nanoserver1 hello-world:nanoserver-1809

# # api
# docker run --name  sms1_nanoserver2 hello-world:nanoserver-1809

# # migration
# docker run --name  sms1_nanoserver3 hello-world:nanoserver-1809

# # angular
# docker run --name  sms1_nanoserver4 hello-world:nanoserver-1809

# # topshelf
# docker run --name  sms1_nanoserver5 hello-world:nanoserver-1809

# #
# # SMS2
# #
# #sql
# docker run --memory 6048mb --name  sms2_servercore1 mcr.microsoft.com/windows/servercore:1809

# # rabbitmq
# docker run --name  sms2_nanoserver1 hello-world:nanoserver-1809

# # api
# docker run --name  sms2_nanoserver2 hello-world:nanoserver-1809

# # migration
# docker run --name  sms2_nanoserver3 hello-world:nanoserver-1809

# # angular
# docker run --name  sms2_nanoserver4 hello-world:nanoserver-1809

# # topshelf
# docker run --name  sms2_nanoserver5 hello-world:nanoserver-1809

docker ps