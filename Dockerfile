FROM tomcat 
WORKDIR webapps 
COPY ../simple_web_application@2/target/WebApp.war .
RUN rm -rf ROOT && mv WebApp.war ROOT.war
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
