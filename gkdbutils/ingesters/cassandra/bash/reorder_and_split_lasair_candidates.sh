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
  cat $file | awk -F, '{print $1","$32","$2","$3","$4","$5","$6","$7","$8","$9","$10","$11","$12","$13","$14","$15","$16","$17","$18","$19","$20","$21","$22","$23","$24","$25","$26","$27","$28","$29","$30","$31","$33","$34","$35","$36","$37","$38","$39","$40","$41","$42","$43","$44","$45","$46","$47","$48","$49","$50","$51","$52","$53","$54","$55","$56","$57","$58","$59","$60","$61","$62","$63","$64","$65","$66","$67","$68","$69","$70","$71","$72","$73","$74","$75","$76","$77","$78","$79","$80","$81","$82","$83","$84","$85","$86","$87","$88","$89","$90","$91","$92","$93","$94","$95","$96","$97","$98","$99","$100","$101","$102","$103","$104","$105}' | sed -e 's/,decl,/,dec,/' | sed -e 's/NULL//g' | parallel --header : --pipe -N${NLINES} "cat >${newfile}_{#}.csv"
done
