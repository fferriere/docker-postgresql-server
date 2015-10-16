docker-postgresql-server
========================

This project create a Postgresql server in docker container.
The container is based on [docker-postgresql-base](https://github.com/fferriere/docker-postgresql-base) image.
It use volume from [docker-postgresql-data](https://github.com/fferriere/docker-postgresql-data).

Build
-----

To build container run `build.sh` script. You can customize image's name with `FFERRIERE_PG_SERVER_IMAGE` variable. Example :
```
$ FFERRIERE_PG_SERVER_IMAGE="prefix/pg-server" ./build.sh
```

Run
---

To run container execute `run.sh` script.

If you have customized build of [docker-postgresql-data](https://github.com/fferriere/docker-postgresql-data) you should give `FFERRIERE_PG_DATA_NAME` variable.

You can customize container's name with `FFERRIERE_PG_SERVER_NAME`. Example :
```
$ FFERRIERE_PG_SERVER_IMAGE="prefix/pg-server" FFERRIERE_PG_SERVER_NAME="prefix-pg-server" \
    FFERRIERE_PG_DATA_NAME="prefix-pg-data" ./run.sh
```

You can also add docker options on run with `FFERRIERE_PG_SERVER_DOCKER_ARGS` variable. Example :
```
    FFERRIERE_PG_SERVER_DOCKER_ARGS='-p 5432:5432' ./run.sh
```
