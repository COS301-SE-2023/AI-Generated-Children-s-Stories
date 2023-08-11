FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy the jar file into our app
COPY backend-0.0.1-SNAPSHOT.jar /app

# Exposing port 8080
EXPOSE 8080

# Starting the application
CMD ["java", "-jar", "backend-0.0.1-SNAPSHOT.jar"]