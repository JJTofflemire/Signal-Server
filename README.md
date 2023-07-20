# Signal-Server Docker

- A docker container for Signal-Server v9.81.0 running on Eclipse Temurin

# Installation

## Compilation

Create a `signal-server` Docker image:

```
docker build --no-cache -t signal-server:1.0 .
```

If you need to reinstall, first run `docker rmi -f signal-server:1.0`

Generate the correct cluster volumes:

```
docker compose -f docker-compose-first-run.yml up -d && docker compose -f docker-compose-first-run.yml down
```

If you call the main `docker-compose.yml` instead of `docker-compose-first-run.yml`, the server will fail with an error related to not being able to connect to the redis cluster

You can fix this by listing all volumes and deleting the ones you just generated:

```
docker volume ls

docker volume rm -f <name-1>
docker volume rm -f <name-2>
etc
```

## Configuration

Folllow [`config-documentation.md` from Main](https://github.com/JJTofflemire/Signal-Server/blob/main/docs/config-documentation.md), and make sure to also follow the [Docker configuration](https://github.com/JJTofflemire/Signal-Server/blob/main/docs/config-documentation.md#dockerized-signal-server-documentation)

## Starting the container

Start the server:

```
docker compose up
```

### Starting the container with [`filtered-docker-compose.sh`](filtered-docker-compose.sh)

This script just calls a one-liner `docker-compose up --no-log-prefix` and runs it through some `awk` / `sed` filters

- Currently the long datadog failed html output is the only thing omitted (since it throws 100 lines of code every couple of seconds and provides no useful info)

- Also colors the words `INFO`, `WARN`, and `ERROR` to green, orange, and red respectively to make it easier to read the server's logs

## To Do

### Running the server

- Convert all localhost configs to a real server (using NGINX) that a client could connect to following [this guide](https://github.com/madeindra/signal-setup-guide/tree/master/signal-server-2.92)

- Confirm that AWS / Google Cloud function as intended

- Fix the screwy `docker-compose` first run requirement

### Extra Credit

- Write scripts for AWS / Google Cloud cli

- Check out a [local DynamoDB Docker instance](https://github.com/madeindra/signal-setup-guide/blob/master/signal-server-5.xx/docker-compose.yml)

- Set up Signal-iOS