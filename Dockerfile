FROM tomcat 
WORKDIR webapps 
COPY target/WebApp.war .
RUN rm -rf ROOT && mv WebApp.war ROOT.war
RUN /usr/local/tomcat/bin/startup.sh
ENTRYPOINT [ "sleep", "3600"]
