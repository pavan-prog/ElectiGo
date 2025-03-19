# Use OpenJDK 17 as the base image for the container
FROM openjdk:17

# Expose port 8080 for the application to be accessed externally
EXPOSE 8080

# Add the Spring Boot JAR file from the local target folder to the container

ADD target/voting.war voting.war

# Define the entry point to run the Spring Boot application using Java
ENTRYPOINT ["java", "-jar", "voting.war"]
