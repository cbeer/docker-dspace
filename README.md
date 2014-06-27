docker-dspace
==============

```console
$ docker pull cbeer/docker-dspace

# run once:
$ docker run --link some-postgres-container:postgres -p 8080:8080 cbeer/docker-dspace /tmp/seed-dspace-database.sh

$ docker run --link some-postgres-container:postgres -p 8080:8080 cbeer/docker-dspace
$ curl http://localhost:8080/jspui
```
