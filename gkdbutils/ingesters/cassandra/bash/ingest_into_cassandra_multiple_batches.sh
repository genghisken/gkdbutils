#!/bin/bash

# Import a cassandra table. The data must be split into chunks because of a memory
# leak in the COPY command.

if [ $# -ne 6 ]
then
    echo "Usage: `basename $0` <keyspace> <table> <batches prefix> <data prefix> <batches directory> <n processes>"
    exit 1
fi

export KEYSPACE=$1
export TABLE=$2
export BATCHPREFIX=$3
export DATAPREFIX=$4
export BATCHESDIR=$5
export NPROCESSES=$6



for SUBPREFIX in $(for file in $(find $BATCHESDIR -type d | grep $BATCHPREFIX | awk -F_ '{print $0" "$NF}' | sort -nk2 | awk '{print $1}' | uniq); do echo $file; done)
  do ingest_into_cassandra.sh $KEYSPACE $TABLE $DATAPREFIX $SUBPREFIX $NPROCESSES
done
