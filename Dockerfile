FROM tomcat:9-jdk17

# Update and install vi to edit files inside the container if necessary
RUN apt update -y && apt install vim -y

# Copy BIRT
COPY ./Docker/birt/birt/ /usr/local/tomcat/webapps/ROOT/

# Copy Tomcat stuff
COPY ./Docker/birt/vin-run-container.sh /usr/local/tomcat/
COPY ./Docker/birt/tomcat/conf/context.xml /usr/local/tomcat/conf/

# Copy the taglibs that is used by the test.jsp to make sure the jndi context is connected and working
COPY ./Docker/birt/jstl/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# Copy MySql driver
COPY ./Docker/birt/jdbc/mysql/ /usr/local/tomcat/lib/
COPY ./Docker/birt/jdbc/mysql/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# Map Reports folder
VOLUME /usr/local/tomcat/webapps/ROOT/report

# Setup environment variables
ENV JAVA_OPTS ""

# Start
CMD /usr/local/tomcat/vin-run-container.sh

# Port
EXPOSE 8080
