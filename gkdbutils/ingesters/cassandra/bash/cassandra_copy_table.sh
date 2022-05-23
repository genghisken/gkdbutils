#!/bin/bash

# Dump a full cassandra table!

if [ $# -ne 3 ]
then
    echo "Usage: `basename $0` <keyspace> <table> <filename>"
    exit 1
fi

export KEYSPACE=$1
export TABLE=$2
export FILE=$3
cqlsh -e "COPY $KEYSPACE.$TABLE TO '$FILE' WITH HEADER = TRUE;"

