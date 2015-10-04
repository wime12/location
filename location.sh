#!/bin/sh
AWKLIB=~/.awklib
SHLIB=~/.shlib

. $SHLIB/urlencode.sh

separator="|"
script=0

while getopts es: opt; do
  case $opt in
    e) script=1
       shift
      ;;
    s) separator=$OPTARG
       shift 2
  esac
done

separator="${separator:-|}"

fetch -q -o - "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text=%27$(urlencode "$1")%27" |
awk  -v script=$script -v separator="$separator" -f $AWKLIB/getxml.awk -f $AWKLIB/location.awk /dev/stdin
