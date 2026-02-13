FROM eclipse-temurin:17-jdk-jammy


RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY target/selfhealing-0.0.1-SNAPSHOT.jar app.jar

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
