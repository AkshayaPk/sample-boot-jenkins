FROM java:8
COPY target/sample-0.0.1-SNAPSHOT.jar /tmp/sample-0.0.1-SNAPSHOT.jar
CMD [ "java", "-jar", "/tmp/sample-0.0.1-SNAPSHOT.jar", "--server.servlet.context-path=/sample" ,"&" ]
#Dockerfile Dev Branch Ready
#Dockerfile ready
