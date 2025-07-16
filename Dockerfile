# Stage 1: Build Spring Boot app with embedded Angular
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Create final runtime image
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/gift-shop-api.jar app.jar

# Optional: Set active profile
ENV SPRING_PROFILES_ACTIVE=test

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]






# Stage 1: Build the Spring Boot app
# FROM maven:3.8.5-openjdk-17 as builder
# WORKDIR /app
# COPY . .
# RUN mvn clean package -DskipTests

# # Stage 2: Run the app
# FROM openjdk:17-jdk-alpine
# WORKDIR /app
# COPY --from=builder /app/target/gift-shop-api.jar app.jar

# # Set active profile and expose port
# ENV SPRING_PROFILES_ACTIVE=test
# EXPOSE 8080
# ENTRYPOINT ["java", "-jar", "app.jar"]
