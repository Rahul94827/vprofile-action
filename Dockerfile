FROM eclipse-temurin:11-jdk AS BUILD_IMAGE
RUN apt-get update && apt-get install -y maven
COPY ./ vprofile-project
RUN cd vprofile-project && mvn clean install

# Runtime stage
FROM tomcat:9-jdk11-temurin
LABEL "Project"="Vprofile"
LABEL "Author"="Rahul"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
