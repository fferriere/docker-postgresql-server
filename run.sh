#!/bin/bash

NAME='fferriere-postgresql-server'
if [ -n "$FFERRIERE_PG_SERVER_NAME" ]; then
    NAME="$FFERRIERE_PG_SERVER_NAME"
fi

DATA_NAME='fferriere-postgresql-data'
if [ -n "$FFERRIERE_PG_DATA_NAME" ]; then
    DATA_NAME="$FFERRIERE_PG_DATA_NAME"
fi

IMAGE='fferriere/postgresql-server'
if [ -n "$FFERRIERE_PG_SERVER_IMAGE" ]; then
    IMAGE="$FFERRIERE_PG_SERVER_IMAGE"
fi

NB_ROWS=$(docker ps | grep -w "$NAME" | wc -l)
if [ "$NB_ROWS" -gt 0 ]; then
    echo 'already started' >&2
    exit 1
fi

NB_ROWS=$(docker ps -a | grep -w "$NAME" | wc -l)
if [ "$NB_ROWS" -gt 0 ]; then
    docker rm "$NAME"
fi

ENV_ARGS=''
if [ -n "$FFERRIERE_PG_SERVER_USER" ]; then
    ENV_ARGS="$ENV_ARGS -e PG_USER=$FFERRIERE_PG_SERVER_USER"
fi
if [ -n "$FFERRIERE_PG_SERVER_PASS" ]; then
    ENV_ARGS="$ENV_ARGS -e PG_PASS=$FFERRIERE_PG_SERVER_PASS"
fi
if [ -n "$FFERRIERE_PG_SERVER_DBNAME" ]; then
    ENV_ARGS="$ENV_ARGS -e PG_DBNAME=$FFERRIERE_PG_SERVER_DBNAME"
fi

RUN_ARGS='-d'
if [ $(echo "$@" | grep "bash" | wc -l) -gt 0 ]; then
    RUN_ARGS='--rm -ti'
fi

if [ -n "$FFERRIERE_PG_SERVER_DOCKER_ARGS" ]; then
    RUN_ARGS="$RUN_ARGS $FFERRIERE_PG_SERVER_DOCKER_ARGS"
fi

docker run $RUN_ARGS \
  --name $NAME \
  --volumes-from $DATA_NAME \
  $ENV_ARGS \
  $IMAGE $@
