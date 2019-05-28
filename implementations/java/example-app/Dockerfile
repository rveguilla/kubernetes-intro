FROM openjdk:11-jdk-slim AS java-build

WORKDIR /gradle

COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle
RUN ./gradlew build || return 0
COPY src ./src
RUN ./gradlew build

FROM openjdk:11-jre-slim AS java-run
WORKDIR /app

COPY --from=java-build /gradle/build/libs/app.jar ./app.jar

CMD ["java", "-jar", "app.jar"]