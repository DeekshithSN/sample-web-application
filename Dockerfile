# Use a base image with Java and Tomcat installed
FROM tomcat:9-jdk11

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the WebApp.war file into the Tomcat webapps directory and rename it to ROOT.war
COPY target/WebApp.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
