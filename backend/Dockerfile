# Use an official OpenJDK runtime as a parent image
FROM openjdk

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged JAR file into the container
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the application will run on
EXPOSE 8080

# Run the application when the container starts
CMD ["java", "-jar", "app.jar"]
