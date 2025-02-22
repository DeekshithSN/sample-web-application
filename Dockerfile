# Use Maven with OpenJDK 8 as the build stage
FROM maven:3.8.6-openjdk-8 AS base

WORKDIR /app

# Copy Maven project files
COPY pom.xml .

# Download dependencies to cache them
RUN mvn dependency:go-offline

# Copy application source code
COPY . .

# Build the WAR file
RUN mvn clean package

# Use Tomcat as the final runtime image
FROM tomcat:latest

WORKDIR /usr/local/tomcat/webapps

# Copy the built WAR file to Tomcat's webapps directory
COPY --from=base /app/target/*.war ./ROOT.war

# Start Tomcat in the foreground
ENTRYPOINT ["catalina.sh", "run"]
