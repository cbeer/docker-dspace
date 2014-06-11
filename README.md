docker-fcrepo4
==============

```console
$ docker pull cbeer/dspace

# run once:
$ docker run --link some-postgres-container:postgres -p 8080:8080 cbeer/dspace /tmp/seed-dspace-database.sh

$ docker run --link some-postgres-container:postgres -p 8080:8080 cbeer/dspace
$ curl http://localhost:8080/jspui
```
