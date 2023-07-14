# Signal-Server Docker

- A docker container for Signal-Server v9.81.0 running on Debian Bookworm-Slim

# Installation

## Compilation

Create a `signal-server` Docker image:

```
docker build --no-cache -t signal-server .
```

If you need to reinstall, first run `docker rmi -f signal-server`

Generate the correct cluster volumes:

```
docker-compose -f docker-compose-first-run.yml up -d && docker-compose -f docker-compose-first-run.yml down
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
docker-compose up
```

To stop the server, run `docker-compose down` even if you you `^C` the `docker-compose up`

# To Do

- Fix the weird first docker-compose run needed to generate the correct volumes for the redis-cluster

- Figure out ports and connecting to clients