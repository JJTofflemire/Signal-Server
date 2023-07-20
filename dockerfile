FROM eclipse-temurin:17

WORKDIR /app

RUN wget -q https://github.com/signalapp/Signal-Server/archive/9c93d379a82428c27c50034a8ecd7eb36336e575.zip && jar xf 9c93d379a82428c27c50034a8ecd7eb36336e575.zip && mv Signal-Server-9c93d379a82428c27c50034a8ecd7eb36336e575 Signal-Server && chmod -R +777 Signal-Server && rm 9c93d379a82428c27c50034a8ecd7eb36336e575.zip 

COPY WhisperServerService.java /app/Signal-Server/service/src/main/java/org/whispersystems/textsecuregcm/

WORKDIR /app/Signal-Server

RUN ./mvnw clean install -DskipTests -Pexclude-spam-filter

CMD jar_file=$(find service/target -name "TextSecureServer*.jar" ! -name "*-tests.jar" | head -n 1) && if [ -n "$jar_file" ] && [ -f "$jar_file" ]; then echo -e "\nStarting Signal-Server using $jar_file\n" && sleep 4 && java -jar -Dsecrets.bundle.filename=personal-config/config-secrets-bundle.yml "$jar_file" server personal-config/config.yml; else echo -e "\nNo valid Signal-Server JAR file found."; fi