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

## Configuration

Update all redis sections in `config.yml` to:

```
  configurationUri: redis://redis-node-5:6379
```

All configuration is the same as in the main branch, and the `server.jar` file gets called the same way from inside the Docker container

## Starting the container

Start the server:

```
docker-compose up
```

To stop the server, run `docker-compose down` even if you you `^C` the `docker-compose up`

# To Do

- Fix the weird first docker-compose run needed to generate the correct volumes for the redis-cluster

- Figure out ports and connecting to clients

- Switch to a lighter/quicker to install Docker image that ships with openjdk / maven