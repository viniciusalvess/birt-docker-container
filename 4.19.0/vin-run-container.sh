# Copy all reports from report_default to the container report folder. This is a workaround for Windows clearing the volume folder after the container starts.
cp -rf /usr/local/tomcat/webapps/ROOT/report_default/* /usr/local/tomcat/webapps/ROOT/report/

export JAVA_OPTS="$JAVA_OPTS -Dbirt.font.config=/usr/local/tomcat/birt-config/fontsConfig.xml"

echo "Starting Tomcat with JAVA_OPTS: $JAVA_OPTS"

sh  /usr/local/tomcat/bin/catalina.sh run