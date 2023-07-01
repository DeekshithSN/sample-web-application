FROM tomcat 
WORKDIR webapps 
RUN ls -ltr
RUN find . -name "*.war"
COPY target/WebApp.war .
RUN rm -rf ROOT && mv WebApp.war ROOT.war
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
