FROM tomcat 
WORKDIR webapps 
COPY /root/.jenkins/jobs/DevOps-Demo-Pipeline/workspace@2/target/WebApp.war .
RUN rm -rf ROOT && mv WebApp.war ROOT.war
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
