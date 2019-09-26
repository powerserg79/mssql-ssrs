```
docker run -d -p 1433:1433 -v C:/temp/:C:/temp/ -e sa_password=Qwerty12345! -e ACCEPT_EULA=Y -e attach_dbs="" ss-mssql:angus
```