# Copy all reports from report_default to the container report folder. This is a workaround for Windows clearing the volume folder after the container starts.
cp -R /usr/local/tomcat/webapps/ROOT/report_default/* /usr/local/tomcat/webapps/ROOT/report/
sh  /usr/local/tomcat/bin/catalina.sh run 