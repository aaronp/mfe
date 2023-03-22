FROM virtuslab/scala-cli:latest AS build
RUN mkdir /app
COPY ["Client.scala", "/app/"]
COPY ["build.sh", "/app/"]
WORKDIR /app
RUN source build.sh && buildLocally

FROM openjdk:18-oraclelinux8
RUN mkdir /app
COPY --from=build /app/* /app
WORKDIR /app

# use -cp rather than -jar as there are multiple main entry points
# see Client.scala comment for how to run
CMD java -jar client.jar 