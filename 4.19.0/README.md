## BIRT VERSION 4.19.0
###### ```Download file: birt-runtime-4.19.0-202503120947.zip```

This version doesn't have any customisations, it has the generic version from the zip file.

### Build image locally
```sh
docker build -t your-registry/birt-docker:4.19.0 -f ./Dockerfile .
```

### Run image locally without compose
```sh
docker run -d --network=your-docker-network-if-you-have-one -p 9999:8080 --name birt --env-file ./.env -v /your-volume-path:/usr/local/tomcat/webapps/ROOT/report your-registry/birt:4.19.0
```

### Docker Compose and .env examples
If you need to run this image locally to access the birt instance without https, use the ```viniciusalvess/birt-docker:4.19.0-dev``` image.
```yml
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
# MySql
JAVA_OPTS=" -Ddb.server=10.0.0.142 -Ddb.port=3306 -Ddb.username=root -Ddb.password=root -Ddb.database=devdb -Ddb.jndiname=jdbc/birtdbcontext -Ddb.driverclass=com.mysql.cj.jdbc.Driver -Ddb.type=mysql -DuseSessionId=false -Duser.country=US -Duser.language=en -Duser.locale=en_US -DBIRT_VIEWER_LOCALE=en_US"

# Firebird
#JAVA_OPTS=" -Ddb.server=host.docker.internal -Ddb.port=3050 -Ddb.username=sysdba -Ddb.password=yourpass -Ddb.database=path-to-fdb-file -Ddb.jndiname=jdbc/birtdbcontext -Ddb.driverclass=org.firebirdsql.jdbc.FBDriver -Ddb.type=firebirdsql -DuseSessionId=false  -Duser.country=BR -Duser.language=pt -Duser.locale=pt_BR -DBIRT_VIEWER_LOCALE=pt_BR"

```

