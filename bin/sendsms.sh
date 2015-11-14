#!/bin/bash

#get main config
source "$1"

SMSHOST=10.10.23.190
SMSPORT=80
SMSUSER=sitemonitor
SMSPASS=sitemonitor
SMSFROM=$2
SMSTO=$3
SMSTEXT=$4

echo `date $LOGDATEFORMAT`" Sending SMS"
echo "conf=$1 from=$2 to=$3 text=$4"
ENCODED=$(echo -n "$SMSTEXT" | \
perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg');
#URL="http://$SMSHOST:$SMSPORT/sendsms/send.php?username=$SMSUSER&password=$SMSPASS&from=$SMSFROM&to=$SMSTO&text=$ENCODED"

URL="http://$SMSHOST:$SMSPORT/kannel/php-admin/sendsms.php?to=$SMSTO&text=$ENCODED&submit=Send+Message"

#pobranie strony
/usr/bin/wget \
--output-document=/dev/null \
--no-proxy \
$URL 

echo `date $LOGDATEFORMAT`" Sending SMS - done"
