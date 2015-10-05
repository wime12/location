#!/bin/sh
AWKLIB=~/.awklib
SHLIB=~/.shlib

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

#fetch -q -o - \
curl -m 4 -s \
"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text=%27"$(urlencode "$1")"%27" |
awk -v script=$script -v separator="$separator" -f $AWKLIB/getxml.awk -f $AWKLIB/location.awk /dev/stdin
