#!/bin/sh

AWKLIB=${AWKLIB:-/usr/local/share/awklib}
SHLIB=${SHLIB:-/usr/local/share/shlib}
AWKFILE_DIR=${AWKFILE_DIR:-/usr/local/share/location}

. $SHLIB/urlencode.sh

separator="|"
script=1

while getopts hs: opt; do
  case $opt in
    h) script=0
      ;;
    s) separator=$OPTARG
  esac
done

shift $((OPTIND-1))

separator="${separator:-|}"

#curl -m 4 -s \
fetch -q -o - \
"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text=%27"$(urlencode "$1")"%27" |
awk -v script=$script -v separator="$separator" -f $AWKLIB/getxml.awk -f $PREFIX/share/location/location.awk /dev/stdin
