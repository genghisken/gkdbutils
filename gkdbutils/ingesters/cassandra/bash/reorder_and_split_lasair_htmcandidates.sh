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
  cat $file | sed -e 's/\r//' | awk -F, '{print $52","$53","$54","$2","$32","$3","$4","$5","$6","$7","$8","$9","$10","$11","$12","$13","$14","$15","$16","$17","$18","$19","$20","$21","$22","$23","$24","$25","$26","$27","$28","$29","$30","$31","$33","$34","$35","$36","$37","$38","$39","$40","$41","$42","$43","$44","$45","$1","$46","$47","$48","$49","$50","$51}' | sed -e 's/,decl,/,dec,/' | sed -e 's/NULL//g' | parallel --header : --pipe -N${NLINES} "cat >${newfile}_{#}.csv"
done
