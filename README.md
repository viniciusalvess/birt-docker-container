# BIRT Docker Repository

## Introduction

This repository provides Docker images for running **Eclipse BIRT
Runtime** in a containerized environment using **Apache Tomcat**.

The project originally started to simplify running BIRT alongside custom
applications. Earlier versions of the images include personal
modifications required for specific use cases. Newer versions provide a
**clean, generic BIRT runtime** extracted directly from the official
distribution.

------------------------------------------------------------------------

# Available BIRT Versions

  ------------------------------------------------------------------------
  Version             Type             Description
  ------------------- ---------------- -----------------------------------
  **4.14.0**          Custom           Includes personal customizations to
                                       support earlier application
                                       integrations

  **4.17.0**          Custom           Includes personal customizations

  **4.19.0**          Generic          Official BIRT runtime without
                                       modifications

  **4.22.0**          Generic          Official BIRT runtime without
                                       modifications (recommended)
  ------------------------------------------------------------------------

The **4.22.0 image is the recommended version** for most users.

------------------------------------------------------------------------

# Quick Start

If you simply want to run BIRT locally without building the image
yourself, the easiest method is using **Docker Compose**.

This repository also allows you to build the image locally if needed.

------------------------------------------------------------------------

# Build the Image Locally

Navigate to the desired version directory (for example `4.22.0`) and
build the Docker image.

``` bash
docker build -t your-registry/birt-docker:4.22.0 -f ./Dockerfile .
```

------------------------------------------------------------------------

# Running the Container Without Docker Compose

You can run the container directly using Docker:

``` bash
docker run -d \
  --name birt \
  --network your-docker-network-if-you-have-one \
  -p 9999:8080 \
  --env-file ./.env \
  -v /your-volume-path:/usr/local/tomcat/webapps/ROOT/report \
  your-registry/birt-docker:4.22.0
```

### Parameters

  -----------------------------------------------------------------------
  Option                              Description
  ----------------------------------- -----------------------------------
  `-p 9999:8080`                      Exposes the BIRT web viewer at
                                      `http://localhost:9999`

  `--env-file`                        Loads database configuration
                                      variables

  `-v`                                Mounts your report directory into
                                      the container

  `--network`                         Optional network if the container
                                      must communicate with other
                                      containers
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# Running with Docker Compose

Using Docker Compose simplifies configuration and startup.

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

### Development Mode (HTTP)

If you want to run BIRT locally **without HTTPS**, replace the image
with:

    viniciusalvess/birt-docker:4.22.0-dev

This development image is configured for easier local testing.

------------------------------------------------------------------------

# Environment Configuration

Database connection settings are passed using the `JAVA_OPTS`
environment variable.

Example `.env` file:

``` bash
# MySQL Example
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

### Firebird Example

``` bash
#JAVA_OPTS="
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

# Reports Directory

Reports must be mounted inside the container at:

    /usr/local/tomcat/webapps/ROOT/report

Example structure:

    reports/
     ├── invoice.rptdesign
     ├── membership-summary.rptdesign
     └── financial-report.rptdesign

------------------------------------------------------------------------

# Accessing the BIRT Viewer

Once the container is running, access the BIRT web viewer:

    http://localhost:9999

Example report URL:

    http://localhost:9999/frameset?__report=report/invoice.rptdesign

------------------------------------------------------------------------

# Notes

-   The container runs BIRT using **Apache Tomcat**.
-   Reports must exist in the mounted `report` directory.
-   Ensure your database JDBC driver matches the configuration in
    `JAVA_OPTS`.
-   Version `4.22.0` is recommended for new deployments.

------------------------------------------------------------------------

# License

BIRT is distributed under the Eclipse Public License.\
This repository only provides containerization for the runtime.
