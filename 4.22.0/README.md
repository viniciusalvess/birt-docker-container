# BIRT Docker Image

Docker image for running **Eclipse BIRT Runtime 4.22.0** inside a Tomcat
container.

## BIRT Version

**Version:** `4.22.0`\
**Download:** `birt-runtime-4.22.0-202512100727.zip`

This image contains the **official BIRT runtime distribution without
modifications**.\
The runtime is extracted directly from the official ZIP archive.

------------------------------------------------------------------------

# Build the Image Locally

``` bash
docker build -t your-registry/birt-docker:4.22.0 -f ./Dockerfile .
```

------------------------------------------------------------------------

# Run the Container Without Docker Compose

``` bash
docker run -d \
  --name birt \
  --network your-docker-network-if-you-have-one \
  -p 9999:8080 \
  --env-file ./.env \
  -v /your-report-path:/usr/local/tomcat/webapps/ROOT/report \
  your-registry/birt-docker:4.22.0
```

### Parameters

  -----------------------------------------------------------------------
  Option                              Description
  ----------------------------------- -----------------------------------
  `-p 9999:8080`                      Exposes the BIRT web viewer on
                                      `http://localhost:9999`

  `--env-file`                        Loads database configuration
                                      variables

  `-v`                                Mounts your report directory inside
                                      the container

  `--network`                         Optional Docker network if BIRT
                                      must access other containers
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# Running with Docker Compose

Example `docker-compose.yml`:

``` yaml
services:
  birt:
    image: viniciusalvess/birt-docker:4.22.0
    container_name: birt
    ports:
      - "9999:8080"
    volumes:
      - ./reports:/usr/local/tomcat/webapps/ROOT/report
    env_file:
      - .env
    restart: unless-stopped
```

------------------------------------------------------------------------

# Development Image (HTTP)

If you need to run BIRT **locally without HTTPS** (for development or
testing), use the development image:

    viniciusalvess/birt-docker:4.22.0-dev

This image is configured for easier local access.

------------------------------------------------------------------------

# Environment Configuration (.env)

BIRT database connectivity is configured via the `JAVA_OPTS` environment
variable.

## MySQL Example

``` bash
JAVA_OPTS="
-Ddb.server=10.0.0.142
-Ddb.port=3306
-Ddb.username=root
-Ddb.password=root
-Ddb.database=devdb
-Ddb.jndiname=jdbc/birtdbcontext
-Ddb.driverclass=com.mysql.cj.jdbc.Driver
-Ddb.type=mysql
-DuseSessionId=false
-Duser.country=US
-Duser.language=en
-Duser.locale=en_US
-DBIRT_VIEWER_LOCALE=en_US
"
```

## Firebird Example

``` bash
JAVA_OPTS="
-Ddb.server=host.docker.internal
-Ddb.port=3050
-Ddb.username=sysdba
-Ddb.password=yourpass
-Ddb.database=/path-to-database.fdb
-Ddb.jndiname=jdbc/birtdbcontext
-Ddb.driverclass=org.firebirdsql.jdbc.FBDriver
-Ddb.type=firebirdsql
-DuseSessionId=false
-Duser.country=BR
-Duser.language=pt
-Duser.locale=pt_BR
-DBIRT_VIEWER_LOCALE=pt_BR
"
```

------------------------------------------------------------------------

# Report Directory

Reports must be mounted into the container at:

    /usr/local/tomcat/webapps/ROOT/report

Example structure:

    reports/
     ├── invoice.rptdesign
     ├── membership-summary.rptdesign
     └── financial-report.rptdesign

------------------------------------------------------------------------

# Accessing the BIRT Viewer

Once the container is running:

    http://localhost:9999

Example report URL:

    http://localhost:9999/frameset?__report=report/invoice.rptdesign

------------------------------------------------------------------------

# Notes

-   The container uses **Apache Tomcat** as the servlet container.
-   Reports must exist in the mounted `report` directory.
-   Database drivers must match the driver defined in `JAVA_OPTS`.
