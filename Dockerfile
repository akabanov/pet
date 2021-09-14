# syntax=docker/dockerfile:1.3

FROM maven AS package

WORKDIR /app
COPY src/ src/
COPY pom.xml .
RUN --mount=type=cache,target=/root/.m2/repository mvn -DskipTests=true package


FROM openjdk:11-jre-slim

WORKDIR /app
COPY --from=package /app/target/spring-petclinic*.jar spring-petclinic.jar

CMD ["java", "-jar", "-Dspring-boot.run.profiles=mysql", "spring-petclinic.jar"]
