FROM tomcat 
WORKDIR webapps 
COPY WebApp.war .
RUN rm -rf ROOT && mv WebApp.war ROOT.war
