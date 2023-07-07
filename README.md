# Signal-Server Docker

- A docker container for Signal-Server v9.81.0


To reset the dockerfile image:

```
docker rmi -f signal-server
docker build --no-cache -t signal-server .
```