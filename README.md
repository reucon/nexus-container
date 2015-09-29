# Sonatype Nexus Docker Image

This docker image is [available on Docker Hub](https://hub.docker.com/r/reucon/nexus/).

## Run the Image

```bash
sudo docker run --detach \
  --publish 80:8081 \
  --name nexus \
  --restart always \
  --volume /srv/nexus/sonatype-work:/sonatype-work \
  reucon/nexus:latest
```
## Where is the data stored?

This Nexus container uses host mounted volumes to store persistent data:
- `/srv/nexus/sonatype-work` mounted as `/sonatype-work` in the container

You can fine tune these directories to meet your requirements.

## Upgrade to newer version

To upgrade Nexus to new version you have to do:
1. pull new image,
```bash
sudo docker stop nexus
```

1. stop running container,
```bash
sudo docker rm nexus
```

1. remove existing container,
```bash
sudo docker pull reucon/nexus:latest
```

1. create the container once again with previously specified options.
```bash
sudo docker run --detach \
  --publish 80:8081 \
  --name nexus \
  --restart always \
  --volume /srv/nexus/sonatype-work:/sonatype-work \
  reucon/nexus:latest
```
