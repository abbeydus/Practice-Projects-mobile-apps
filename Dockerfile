FROM maven:3.6.3-openjdk-11-slim AS build
 
ENV DB_HOST=db \
     DB_USERNAME=username \
     DB_PASSWORD=password
 
RUN mkdir -p /usr/local/mobile-app-ws
 
COPY ./src /usr/local/mobile-app-ws/src

COPY ./pom.xml /usr/local/mobile-app-ws/pom.xml
 
WORKDIR /usr/local/mobile-app-ws/
 
RUN mvn -Dmaven.test.skip=true clean package
 

FROM tomcat:8
 
COPY --from=build /usr/local/mobile-app-ws/target/mobile-app-ws-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/mobile-app-ws.war
 
EXPOSE 8080
 
CMD ["catalina.sh", "run"]