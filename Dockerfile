FROM openjdk:8-jre

COPY target/simple_boot-0.0.1-SNAPSHOT.jar myapp.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/.urandom","-jar","/myapp.jar"]