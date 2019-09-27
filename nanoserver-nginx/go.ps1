docker build -t nginx-nanoserver .

docker run -it --name nginx -p 80:80 nginx-nanoserver