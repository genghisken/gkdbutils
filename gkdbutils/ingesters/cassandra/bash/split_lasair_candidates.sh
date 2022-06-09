#!/bin/bash

# Reorder the original Lasair candidates table, moving positions of jd and candid. Split the output into n lines files.

if [ $# -ne 5 ]
then
    echo "Usage: `basename $0` <dump prefix> <dump suffix> <split files prefix> <data directory> <n lines>"
    exit 1
fi

export DUMPPREFIX=$1
export DUMPSUFFIX=$2
export NEWPREFIX=$3
export DATADIR=$4
export NLINES=$5

cd $DATADIR

for file in `ls $DUMPPREFIX*.$DUMPSUFFIX`
do
  newfile=`echo $file | sed -e "s/$DUMPPREFIX/$NEWPREFIX/"`
  cat $file | sed -e 's/,decl,/,dec,/' | sed -e 's/NULL//g' | parallel --header : --pipe -N${NLINES} "cat >${newfile}_{#}.csv"
done
