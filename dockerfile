# Use Ubuntu as the base image
FROM ubuntu:23.10

# Set the working directory inside the container
WORKDIR /app

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends git openjdk-17-jre-headless maven && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/signalapp/Signal-Server.git && cd Signal-Server && git checkout 9c93d37 && cd ..

COPY WhisperServerService.java /app/Signal-Server/service/src/main/java/org/whispersystems/textsecuregcm/

RUN cd Signal-Server && mvn clean install -DskipTests -Pexclude-spam-filter

# Expose port 7006
EXPOSE 7006

# Set the entry point command
CMD jar_file=$(find service/target -name "TextSecureServer*.jar" ! -name "*-tests.jar" | head -n 1) && if [ -n "$jar_file" ] && [ -f "$jar_file" ]; then echo -e "\nStarting Signal-Server using $jar_file\n" && java -jar -Dsecrets.bundle.filename=personal-config/config-secrets-bundle.yml "$jar_file" server personal-config/config.yml; else echo -e "\nNo valid Signal-Server JAR file found."; fi
