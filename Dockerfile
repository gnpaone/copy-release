FROM sbtscala/scala-sbt:eclipse-temurin-24.0.1_9_1.11.7_3.7.4 AS builder

WORKDIR /app
COPY . .

RUN sbt assembly

FROM eclipse-temurin:24-jre
WORKDIR /app
COPY --from=builder /app/target/scala-*/*-assembly*.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
