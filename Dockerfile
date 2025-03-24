# Use the official OpenJDK 21 image as the base image
FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy the built JAR file from target folder
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the port defined in your application.properties (8081)
EXPOSE 8081

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
