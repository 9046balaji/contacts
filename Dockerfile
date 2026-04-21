# syntax=docker/dockerfile:1.7

# -------- Build stage --------
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /workspace

# Cache dependencies first for faster rebuilds.
COPY pom.xml .
RUN --mount=type=cache,target=/root/.m2 mvn -B -q -DskipTests dependency:go-offline

# Copy source and package application jar.
COPY src ./src
RUN --mount=type=cache,target=/root/.m2 mvn -B -DskipTests clean package

# -------- Runtime stage --------
FROM eclipse-temurin:17-jre-jammy AS runtime
WORKDIR /app

# Security and predictable runtime defaults.
RUN apt-get update \
  && apt-get install -y --no-install-recommends curl \
  && rm -rf /var/lib/apt/lists/* \
  && useradd --create-home --uid 10001 springuser

# Copy the fat jar from build stage.
COPY --from=build /workspace/target/*.jar /app/app.jar

USER 10001
EXPOSE 8080

# Simple JVM tuning defaults for containers.
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75 -XX:+UseContainerSupport -Dfile.encoding=UTF-8"

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=5 \
  CMD curl -fsS http://127.0.0.1:8080/actuator/health | grep -q '"status":"UP"' || exit 1

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
