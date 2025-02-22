FROM circleci/jdk8 as base
WORKDIR /app
COPY . .
RUN RUN apt-get update && apt-get install -y maven
RUN mvn clean package
FROM tomcat:latest

# Set working directory to Tomcat's webapps directory
WORKDIR /usr/local/tomcat/webapps

# Copy the WAR file to Tomcat's webapps directory
COPY --from=base /app/target/*.war ./ROOT.war

# Set correct entrypoint to keep Tomcat running in foreground

EXPOSE 8080
ENTRYPOINT ["catalina.sh", "run"]