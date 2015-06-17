#!/bin/bash

THIS_PATH=$(dirname $(realpath $0))

NAME='fferriere/postgresql-server'
if [ -n "$FFERRIERE_PG_SERVER_IMAGE" ]; then
    NAME="$FFERRIERE_PG_SERVER_IMAGE"
fi

docker build -t $NAME $@ $THIS_PATH/.
 
