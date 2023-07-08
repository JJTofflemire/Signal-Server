FROM debian:bookworm-slim

RUN apt update && apt upgrade -y && apt install -y build-essential git openjdk-17-jre-headless

WORKDIR /app

RUN git clone https://github.com/signalapp/Signal-Server.git && cd Signal-Server && git checkout 9c93d37

COPY WhisperServerService.java /app/Signal-Server/service/src/main/java/org/whispersystems/textsecuregcm/

WORKDIR /app/Signal-Server

RUN ./mvnw --quiet clean install -DskipTests -Pexclude-spam-filter

EXPOSE 7006

CMD jar_file=$(find service/target -name "TextSecureServer*.jar" ! -name "*-tests.jar" | head -n 1) && if [ -n "$jar_file" ] && [ -f "$jar_file" ]; then echo -e "\nStarting Signal-Server using $jar_file\n" && java -jar -Dsecrets.bundle.filename=personal-config/config-secrets-bundle.yml "$jar_file" server personal-config/config.yml; else echo -e "\nNo valid Signal-Server JAR file found."; fi
