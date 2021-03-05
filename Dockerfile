FROM tomcat:8.0-alpine
MAINTAINER Rohan Gambhir

ADD sample.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
