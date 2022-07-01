#!/bin/bash

# Import a cassandra table. The data must be split into chunks because of a memory
# leak in the COPY command.

if [ $# -ne 6 ]
then
    echo "Usage: `basename $0` <keyspace> <table> <file prefix> <data directory> <n processes> <delay between batches (seconds)>"
    exit 1
fi

export KEYSPACE=$1
export TABLE=$2
export PREFIX=$3
export DATADIR=$4
export NPROCESSES=$5
export BATCHDELAY=$6

export PROCESSES_CLAUSE=""

if [ $NPROCESSES -gt "0" ]
then
    export PROCESSES_CLAUSE="AND NUMPROCESSES = $NPROCESSES"
fi

export COLS=""

if [ $TABLE == "htmcandidates" ]
then
#    COLS="ssnamenr,jd,candid,chinr,chipsf,dec,decnr,diffmaglim,exptime,fid,field,fwhm,isdiffpos,jdendhist,jdendref,jdstarthist,jdstartref,magap,magapbig,magdiff,magfromlim,maggaia,maggaiabright,magnr,magpsf,magzpsci,magzpscirms,magzpsciunc,nbad,nid,nneg,objectid,ra,ranr,rb,rbversion,scorr,seeratio,sigmagap,sigmagapbig,sigmagnr,sigmapsf,sky,ssdistnr,ssmagnr,ssnrms,sumrat,xpos,ypos,zpclrcov,zpmed,htm10,htm13,htm16"
    COLS="htm10,htm13,htm16,jd,objectid,candid,chinr,chipsf,dec,decnr,diffmaglim,exptime,fid,field,fwhm,isdiffpos,jdendhist,jdendref,jdstarthist,jdstartref,magap,magapbig,magdiff,magfromlim,maggaia,maggaiabright,magnr,magpsf,magzpsci,magzpscirms,magzpsciunc,nbad,nid,nneg,ra,ranr,rb,rbversion,scorr,seeratio,sigmagap,sigmagapbig,sigmagnr,sigmapsf,sky,ssdistnr,ssmagnr,ssnamenr,ssnrms,sumrat,xpos,ypos,zpclrcov,zpmed"
elif [ $TABLE == "sscandidates" ]
then
    COLS="ssnamenr,jd,candid,chinr,chipsf,dec,decnr,diffmaglim,exptime,fid,field,fwhm,isdiffpos,jdendhist,jdendref,jdstarthist,jdstartref,magap,magapbig,magdiff,magfromlim,maggaia,maggaiabright,magnr,magpsf,magzpsci,magzpscirms,magzpsciunc,nbad,nid,nneg,objectid,ra,ranr,rb,rbversion,scorr,seeratio,sigmagap,sigmagapbig,sigmagnr,sigmapsf,sky,ssdistnr,ssmagnr,ssnrms,sumrat,xpos,ypos,zpclrcov,zpmed,htm10,htm13,htm16"
elif [ $TABLE == "old_candidates" ]
then
    COLS="objectid,candid,aimage,aimagerat,bimage,bimagerat,chinr,chipsf,classtar,clrcoeff,clrcounc,clrmed,clrrms,dec,decnr,diffmaglim,distnr,distpsnr1,distpsnr2,distpsnr3,drb,drbversion,dsdiff,dsnrms,elong,exptime,fid,field,fwhm,htmid16,isdiffpos,jd,jdendhist,jdendref,jdstarthist,jdstartref,magap,magapbig,magdiff,magfromlim,maggaia,maggaiabright,magnr,magpsf,magzpsci,magzpscirms,magzpsciunc,mindtoedge,nbad,ncovhist,ndethist,neargaia,neargaiabright,nframesref,nid,nmatches,nmtchps,nneg,objectidps1,objectidps2,objectidps3,pdiffimfilename,pid,programid,programpi,ra,ranr,rb,rbversion,rcid,rfid,scorr,seeratio,sgmag1,sgmag2,sgmag3,sgscore1,sgscore2,sgscore3,sharpnr,sigmagap,sigmagapbig,sigmagnr,sigmapsf,simag1,simag2,simag3,sky,srmag1,srmag2,srmag3,ssdistnr,ssmagnr,ssnamenr,ssnrms,sumrat,szmag1,szmag2,szmag3,tblid,tooflag,xpos,ypos,zpclrcov,zpmed"
elif [ $TABLE == "candidates" ]
then
    COLS="objectid,jd,candid,aimage,aimagerat,bimage,bimagerat,chinr,chipsf,classtar,clrcoeff,clrcounc,clrmed,clrrms,dec,decnr,diffmaglim,distnr,distpsnr1,distpsnr2,distpsnr3,drb,drbversion,dsdiff,dsnrms,elong,exptime,fid,field,fwhm,htmid16,isdiffpos,jdendhist,jdendref,jdstarthist,jdstartref,magap,magapbig,magdiff,magfromlim,maggaia,maggaiabright,magnr,magpsf,magzpsci,magzpscirms,magzpsciunc,mindtoedge,nbad,ncovhist,ndethist,neargaia,neargaiabright,nframesref,nid,nmatches,nmtchps,nneg,objectidps1,objectidps2,objectidps3,pdiffimfilename,pid,programid,programpi,ra,ranr,rb,rbversion,rcid,rfid,scorr,seeratio,sgmag1,sgmag2,sgmag3,sgscore1,sgscore2,sgscore3,sharpnr,sigmagap,sigmagapbig,sigmagnr,sigmapsf,simag1,simag2,simag3,sky,srmag1,srmag2,srmag3,ssdistnr,ssmagnr,ssnamenr,ssnrms,sumrat,szmag1,szmag2,szmag3,tblid,tooflag,xpos,ypos,zpclrcov,zpmed"
elif [ $TABLE == "noncandidates" ]
then
    COLS="objectid,jd,diffmaglim,fid,field,magzpsci,magzpscirms,magzpsciunc,nid"
else
    echo "Unknown table $TABLE. Exiting."
    exit 1
fi

if [ $TABLE == "old_candidates" ]
then
    export TABLE="candidates"
fi

#Sort the file into numeric order, since we don't have a 0 prefix.
cd $DATADIR
for file in `ls $PREFIX*.csv | awk -F_ '{print $0" "$2}' | sort -nk2 | awk '{print $1}'`
do
    echo
    echo Loading file: $file
    cqlsh -e "COPY $KEYSPACE.$TABLE($COLS) FROM '$file' WITH HEADER = TRUE $PROCESSES_CLAUSE;"
    sleep $BATCHDELAY
done

