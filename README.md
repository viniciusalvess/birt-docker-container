## Introduction

This project started as I needed to use Birt with my apps and it wasn't too easy to get Birt working. So the first 2 ```4.14.0 and 4.17.0``` have some personal customisations.

## BIRT Versions
4.14.0 - Custom -> This version has some personal customisations 

4.17.0 - Custom -> This version has some personal customisations 

4.19.0 - Generic -> The birt files are not modified.

## Get Started
If you just want to run the container on your system without building the image from scratch. Just run it with the docker compose file down below, it will make your life easier.

### Build image locally

Change directory into the 4.19.0 directory and build the image.

```sh
docker build -t your-registry/birt-docker:4.19.0 -f ./Dockerfile .
```

Run the container with vanila docker commands.
### Run image locally without compose
```sh
docker run -d --network=your-docker-network-if-you-have-one -p 9999:8080 --name birt --env-file ./.env -v /your-volume-path:/usr/local/tomcat/webapps/ROOT/report your-registry/birt:4.19.0
```

Or run it with a docker compose file.
### Docker Compose and .env examples
If you need to run this image locally to access the birt instance without https, change the docker compose file and use the ```viniciusalvess/birt-docker:4.19.0-dev``` image instead of ```viniciusalvess/birt-docker:4.19.0```.

```yml 
#docker-compose.yml

services:
  birt:
    image: viniciusalvess/birt-docker:4.19.0    
    container_name: birt
    ports:
      - 9999:8080
    volumes:
      - 'path-to-your-report-folder:/usr/local/tomcat/webapps/ROOT/report'
    restart: unless-stopped
    env_file:
      - ./.env 
```

```sh
#.env

# MySql
JAVA_OPTS=" -Ddb.server=10.0.0.142 -Ddb.port=3306 -Ddb.username=root -Ddb.password=root -Ddb.database=devdb -Ddb.jndiname=jdbc/birtdbcontext -Ddb.driverclass=com.mysql.cj.jdbc.Driver -Ddb.type=mysql -DuseSessionId=false -Duser.country=US -Duser.language=en -Duser.locale=en_US -DBIRT_VIEWER_LOCALE=en_US"

# Firebird
#JAVA_OPTS=" -Ddb.server=host.docker.internal -Ddb.port=3050 -Ddb.username=sysdba -Ddb.password=yourpass -Ddb.database=path-to-fdb-file -Ddb.jndiname=jdbc/birtdbcontext -Ddb.driverclass=org.firebirdsql.jdbc.FBDriver -Ddb.type=firebirdsql -DuseSessionId=false  -Duser.country=BR -Duser.language=pt -Duser.locale=pt_BR -DBIRT_VIEWER_LOCALE=pt_BR"

```
