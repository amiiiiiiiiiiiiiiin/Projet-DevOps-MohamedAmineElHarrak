# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and source code
COPY devops-app/pom.xml .
COPY devops-app/src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy the JAR from build stage
COPY --from=build /app/target/devops-app-*.jar app.jar

# Expose port (optional, if needed in the future)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

