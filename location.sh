#!/bin/sh
AWKLIB=~/.awklib
SHLIB=~/.shlib

. $SHLIB/urlencode.sh

while getopts hs: opt; do
  case $opt in
    h) human=1
      ;;
    s) separator=$OPTARG
  esac
done

separator="${separator:-|}"

curl --max-time 4 -s "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text=%27$(urlencode "$1")%27" |
mawk -f $AWKLIB/getxml.awk -f $AWKLIB/location.awk /dev/stdin $separator
