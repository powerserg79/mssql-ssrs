docker build -t nanonode:v1 .

docker run -it --name node -p 80:80 nanonode:v1

