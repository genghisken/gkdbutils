#!/bin/bash
  
# Backup cassandra tables for Lasair.  NOTE: THIS IS UNSAFE AT THE MOMENT.
# Unless we mount a ceph filesystem we are backing up onto a potentially
# unsafe cinder mount.

if [ $# -ne 3 ]
then
    echo "Usage: `basename $0` <keyspace> <directory> <remote location>"
    exit 1
fi

export KEYSPACE=$1
export DIRECTORY=$2
export REMOTE_LOCATION=$3

export CURRENT_BACKUP_CANDIDATES=$DIRECTORY/backup_candidates.csv
export PREVIOUS_BACKUP_CANDIDATES=$DIRECTORY/backup_candidates.old.csv
export CURRENT_BACKUP_NONCANDIDATES=$DIRECTORY/backup_noncandidates.csv
export PREVIOUS_BACKUP_NONCANDIDATES=$DIRECTORY/backup_noncandidates.old.csv
export DAY=`date +"%a"`

cp -p $CURRENT_BACKUP_CANDIDATES $PREVIOUS_BACKUP_CANDIDATES

export TABLE=candidates
export FILE=$CURRENT_BACKUP_CANDIDATES
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE started
/usr/bin/cqlsh -e "COPY $KEYSPACE.$TABLE TO '$FILE' WITH HEADER = TRUE;"
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE completed

sleep 1
cp -p $CURRENT_BACKUP_NONCANDIDATES $PREVIOUS_BACKUP_NONCANDIDATES

export TABLE=noncandidates
export FILE=$CURRENT_BACKUP_NONCANDIDATES
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE started
/usr/bin/cqlsh -e "COPY $KEYSPACE.$TABLE TO '$FILE' WITH HEADER = TRUE;"
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE completed

rm $CURRENT_BACKUP_CANDIDATES.gz
rm $CURRENT_BACKUP_NONCANDIDATES.gz
pigz $CURRENT_BACKUP_CANDIDATES
pigz $CURRENT_BACKUP_NONCANDIDATES
scp -p $CURRENT_BACKUP_CANDIDATES.gz $REMOTE_LOCATION/candidates.$DAY.gz
scp -p $CURRENT_BACKUP_NONCANDIDATES.gz $REMOTE_LOCATION/noncandidates.$DAY.gz
