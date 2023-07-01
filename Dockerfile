FROM tomcat:9-jdk11

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Add your application WAR file to the webapps directory
#COPY src/target/WebApp.war /usr/local/tomcat/webapps/ROOT.war

# Optional: If your application requires additional configuration or dependencies,
# you can add them here

# Set the user to run the container
USER 1001
