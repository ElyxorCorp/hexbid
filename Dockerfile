FROM openjdk:8-jdk-slim AS build-env
ADD java /app 
WORKDIR /app 

RUN apt-get update && \
    apt-get install wget unzip -y
RUN wget https://services.gradle.org/distributions/gradle-4.7-all.zip
RUN mkdir /opt/gradle
RUN unzip -d /opt/gradle gradle-4.7-all.zip

WORKDIR /app 
RUN /opt/gradle/gradle-4.7/bin/gradle shadowJar

FROM gcr.io/distroless/java
COPY --from=build-env /app/build/libs/ /app
WORKDIR /app 

CMD ["hexbid-1.0.0-SNAPSHOT-fat.jar"]
