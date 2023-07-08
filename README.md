# Signal-Server Docker

- A docker container for Signal-Server v9.81.0

Update all redis sections in `sample.yml` to:

```
  configurationUri: redis://redis-node-5:6379
```

To reset the dockerfile image and create a `signal-server` image:

```
docker rmi -f signal-server
docker build --no-cache -t signal-server .
```

Generate the correct cluster volumes:

```
docker-compose -f docker-compose-first-run.yml up -d && docker-compose -f docker-compose-first-run.yml down
```

Start the server:

```
docker-compose up
```

Optionally add `-d` to run it in the background

To stop the server, run `docker-compose down` even if you you `^C` the `docker-compose up`