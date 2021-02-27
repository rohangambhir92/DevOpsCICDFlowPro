FROM tomcat:8.0-alpine
MAINTAINER Rohan Gambhir
RUN apk update
RUN apk add wget
RUN wget --user=admin --password=Password1234 -O /usr/local/tomcat/webapps/sampleapplication.war http://10.127.129.114:8040/artifactory/devopsnagpqa2020cdflow/com/mkyong/CounterWebApp/1.0-SNAPSHOT/CounterWebApp-1.0-SNAPSHOT.war
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
