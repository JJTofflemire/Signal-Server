# Signal-Server Docker

- A docker container for Signal-Server v9.81.0 running on Eclipse Temurin

# Installation

## Compilation

Create a `signal-server` Docker image:

```
docker build --no-cache -t signal-server .
```

If you need to reinstall, first run `docker rmi -f signal-server`

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

## To Do

### Running the server

- Convert all localhost configs to a real server (using NGINX) that a client could connect to following [this guide](https://github.com/madeindra/signal-setup-guide/tree/master/signal-server-2.92)

- Confirm that AWS / Google Cloud function as intended

- See if you can generate the required Bitnami redis-cluster volumes with `docker blah blah blah` instead of using `docker-compose-first-run.yml`

### Extra Credit

- Write scripts for AWS / Google Cloud cli

- Check out a [local DynamoDB Docker instance](https://github.com/madeindra/signal-setup-guide/blob/master/signal-server-5.xx/docker-compose.yml)

- Set up Signal-iOS

- Set up a grep(?) filter to get rid of `datadog` messages