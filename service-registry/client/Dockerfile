FROM virtuslab/scala-cli:latest AS build
RUN mkdir /app
COPY ["Client.scala", "/app/"]
WORKDIR /app
RUN scala-cli --power package Client.scala -o client.jar --assembly

FROM openjdk:18-oraclelinux8
RUN mkdir /app
COPY --from=build /app/* /app
WORKDIR /app
CMD java -jar client.jar