# Stage 1: Build Spring Boot app
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime image
FROM openjdk:17-jdk-alpine
WORKDIR /app

# --- Accept build-time arguments (from GitHub Actions) ---
ARG JWT_SECRET
ARG STRIPE_KEY
ARG RAZOR_PUBLIC_KEY
ARG RAZOR_PRIVATE_KEY
ARG GOOGLE_CLIENT_ID
ARG FACEBOOK_TOKEN_VALIDATION_URL

# --- Set them as environment variables for Spring Boot ---
ENV JWT_SECRET=$JWT_SECRET
ENV STRIPE_KEY=$STRIPE_KEY
ENV RAZOR_PUBLIC_KEY=$RAZOR_PUBLIC_KEY
ENV RAZOR_PRIVATE_KEY=$RAZOR_PRIVATE_KEY
ENV GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID
ENV FACEBOOK_TOKEN_VALIDATION_URL=$FACEBOOK_TOKEN_VALIDATION_URL

# --- Copy the JAR built in previous stage ---
COPY --from=builder /app/target/gift-shop-api.jar app.jar

# --- Set Spring profile (use test or whatever suits your deployment) ---
ENV SPRING_PROFILES_ACTIVE=test

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
