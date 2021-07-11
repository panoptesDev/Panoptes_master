## Minimal Panoptes Docker image
This image is automatically updated by CI

https://hub.docker.com/r/panopteslabs/panoptes/

### Usage:
Run the latest beta image:
```bash
$ docker run --rm -p 8899:8899 --ulimit nofile=700000 panopteslabs/panoptes:beta
```

Run the latest edge image:
```bash
$ docker run --rm -p 8899:8899 --ulimit nofile=700000 panopteslabs/panoptes:edge
```

Port *8899* is the JSON RPC port, which is used by clients to communicate with the network.
