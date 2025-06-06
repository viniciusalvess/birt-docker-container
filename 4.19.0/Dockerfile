FROM tomcat:9-jdk17

# Update and install vi to edit files inside the container if necessary
RUN apt update -y && apt install vim -y fonts-dejavu-core fonts-dejavu-extra

# Copy BIRT
COPY ./dependencies/birt/ /usr/local/tomcat/webapps/ROOT/

# Copy Tomcat stuff
COPY ./vin-run-container.sh /usr/local/tomcat/
COPY ./dependencies/tomcat/conf/context.xml /usr/local/tomcat/conf/
COPY ./dependencies/tomcat/conf/server.xml /usr/local/tomcat/conf/

#if you need to run this container on localhost to access it without https, uncomment this line.
#COPY ./dependencies/tomcat/conf/server-dev.xml /usr/local/tomcat/conf/server.xml

# Copy the taglibs that is used by the test.jsp to make sure the jndi context is connected and working
COPY ./dependencies/other/jstl/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# Copy MySql drivers
COPY ./dependencies/other/jdbc/mysql/ /usr/local/tomcat/lib/
COPY ./dependencies/other/jdbc/mysql/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# Copy Other dependencies
COPY ./dependencies/other/commons-logging/commons-logging-1.3.0.jar /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# Copy Firebird drivers
COPY ./dependencies/other/jdbc/firebird/ /usr/local/tomcat/lib/
COPY ./dependencies/other/jdbc/firebird/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
COPY ./dependencies/other/lang/pt_BR/eclipse/plugins/ /usr/local/tomcat/lib/
COPY ./dependencies/other/lang/pt_BR/eclipse/plugins/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
COPY ./dependencies/other/mail/ /usr/local/tomcat/lib/
COPY ./dependencies/other/mail/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

COPY ./dependencies/fonts/segoe-ui/*.ttf /usr/share/fonts/truetype/

RUN fc-cache -fv

# Map Reports folder
VOLUME /usr/local/tomcat/webapps/ROOT/report

# Setup environment variables
ENV JAVA_OPTS ""

RUN chmod 775 /usr/local/tomcat/vin-run-container.sh

# Start
CMD /usr/local/tomcat/vin-run-container.sh

# Port
EXPOSE 8080
EXPOSE 8443
