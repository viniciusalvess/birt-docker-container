docker stop birt
docker rm -f birt
docker build -t viniciusalvess/birt-docker:latest -f ./Dockerfile .
docker run -d --network=vinsystems-network -p 9999:8080 --name birt --env-file ./.env -v Z:/projects/programming/projects/csharp/VinSystems/Trash/docker-volumes/birt_dev_localhost:/usr/local/tomcat/webapps/ROOT/report viniciusalvess/birt-docker:latest