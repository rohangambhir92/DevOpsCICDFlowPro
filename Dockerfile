FROM tomcat:8.0-alpine
MAINTAINER Rohan Gambhir
RUN apk update
RUN apk add wget
RUN wget --user=admin --password=Password@1234 -O /usr/local/tomcat/webapps/sampleapplication.war http://192.168.56.1:8082/artifactory/ci-cd-pro-rohan/com/mkyong/CounterWebApp/1.0-SNAPSHOT/CounterWebApp-1.0-SNAPSHOT.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
