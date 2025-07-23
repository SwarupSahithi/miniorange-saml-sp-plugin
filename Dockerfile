# Use Maven with JDK 17
FROM maven:3.9.6-eclipse-temurin-17 as build

# Set working directory
WORKDIR /app

# Copy your Maven project files
COPY . .

# Resolve dependencies and build plugin
RUN mvn clean install -DskipTests

# Final lightweight image to hold the .hpi file
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /jenkins-plugin

# Copy the plugin .hpi file from the build stage
COPY --from=build /app/target/*.hpi ./plugin.hpi

# Default command - output plugin file info
CMD ["ls", "-lh", "plugin.hpi"]
