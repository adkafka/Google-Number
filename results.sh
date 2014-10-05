#!/bin/bash

# returns the number of google results for given input
# Examples:
## ./results.sh Hello
## ./results.sh "My Name is" # use quotes to search a string of multiple words

LANG=C


QUERY_INITIAL=$1
QUERY=`echo ${QUERY_INITIAL} | sed -e s/[[:space:]]/%20/g`
FILE=source.html


curl -s -A Mozilla http://www.google.com/search?q=${QUERY} -o ${FILE} #Grab the html file of google search

echo $(cat ${FILE}) > ${FILE} #Remove Line breaks

RESULTS=`cat ${FILE} | sed s/^.*'id="resultStats">About '//g | sed s/' results<.div>'.*$//g` #Take everything before and after the number out of the doc and store it in this variable

rm ${FILE}

#RESULTS=`cat ${FILE} \ 
#| sed s/^.*'<div id="resultStats">About '//g \
#| sed s/' results<.div>'.*$//g ;`

echo "The query ${QUERY_INITIAL} returned about ${RESULTS} results"
