if [ $# -ne 3 ]
then
    echo "Usage: `basename $0` <keyspace> <table> <primary key>"
    exit 1
fi

export KEYSPACE=$1
export TABLE=$2
export PK=$3
cqlsh -e "copy $KEYSPACE.$TABLE ($PK) to '/dev/null'" | sed -n 5p | sed 's/ .*//'
