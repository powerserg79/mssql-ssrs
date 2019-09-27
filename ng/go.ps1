Set-Location $PSScriptRoot

# source 
# https://calebmcelrath.wordpress.com/2018/08/03/static-website-using-docker/
docker build -t webserver-image:v1 .

if(docker inspect -f '{{.State.Running}}' web-dev){
    docker stop web-dev
    docker rm web-dev 
}

docker run --name web-dev -d -it -p 8080:80 webserver-image:v1

docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" web-dev

#http://{ip}:8000
