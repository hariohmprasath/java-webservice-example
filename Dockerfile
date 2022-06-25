# build stage build the jar with all our resources
FROM maven:3.5.2-jdk-8 as build

WORKDIR /
COPY . .

RUN mvn clean package

# package stage
FROM openjdk:8-jdk-alpine
WORKDIR /
# copy only the built jar and nothing else
COPY --from=build /target/todo.jar /

EXPOSE 8080

ENTRYPOINT ["sh","-c","java -jar /todo.jar"]