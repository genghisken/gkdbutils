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

export CURRENT_BACKUP_FORCEDPHOT=$DIRECTORY/backup_forcedphot.csv
export PREVIOUS_BACKUP_FORCEDPHOT=$DIRECTORY/backup_forcedphot.old.csv

export DAY=`date +"%a"`

# *************** CANDIDATES *****************

cp -p $CURRENT_BACKUP_CANDIDATES.gz $PREVIOUS_BACKUP_CANDIDATES.gz
rm $CURRENT_BACKUP_CANDIDATES.gz

export TABLE=candidates
export FILE=$CURRENT_BACKUP_CANDIDATES
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE started
/usr/bin/cqlsh -e "COPY $KEYSPACE.$TABLE TO '$FILE' WITH HEADER = TRUE;"
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE completed

sleep 1

pigz $CURRENT_BACKUP_CANDIDATES
scp -p $CURRENT_BACKUP_CANDIDATES.gz $REMOTE_LOCATION/candidates.$DAY.gz

# *************** FORCEDPHOT *****************

cp -p $CURRENT_BACKUP_FORCEDPHOT.gz $PREVIOUS_BACKUP_FORCEDPHOT.gz
rm $CURRENT_BACKUP_FORCEDPHOT.gz

export TABLE=forcedphot
export FILE=$CURRENT_BACKUP_NONCANDIDATES
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE started
/usr/bin/cqlsh -e "COPY $KEYSPACE.$TABLE TO '$FILE' WITH HEADER = TRUE;"
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE completed

sleep 1

pigz $CURRENT_BACKUP_FORCEDPHOT
scp -p $CURRENT_BACKUP_FORCEDPHOT.gz $REMOTE_LOCATION/forcedphot.$DAY.gz


# ************** NONCANDIDATES ***************

cp -p $CURRENT_BACKUP_NONCANDIDATES.gz $PREVIOUS_BACKUP_NONCANDIDATES.gz
rm $CURRENT_BACKUP_NONCANDIDATES.gz

export TABLE=noncandidates
export FILE=$CURRENT_BACKUP_NONCANDIDATES
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE started
/usr/bin/cqlsh -e "COPY $KEYSPACE.$TABLE TO '$FILE' WITH HEADER = TRUE;"
echo `date '+%Y-%m-%dT%H:%M:%S'` Backup of $TABLE completed

sleep 1

pigz $CURRENT_BACKUP_NONCANDIDATES
scp -p $CURRENT_BACKUP_NONCANDIDATES.gz $REMOTE_LOCATION/noncandidates.$DAY.gz


