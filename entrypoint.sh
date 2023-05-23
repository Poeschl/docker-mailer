#!/usr/bin/env sh
set -e

# set reasonable defaults

SSMTP_TLS=${SSMTP_TLS:-TRUE}
SSMTP_PORT=${SSMTP_PORT:-587}

cat << EOF > /etc/ssmtp/ssmtp.conf
mailhub=$SSMTP_SERVER:$SSMTP_PORT

UseSTARTTLS=$SSMTP_TLS
hostname=localhost
FromLineOverride=TRUE
EOF

if [ -n "$SSMTP_USER" ] || [ -n "$SSMTP_PASS" ]; then
  cat << EOF > /etc/ssmtp/ssmtp.conf
AuthUser=$SSMTP_USER
AuthPass=$SSMTP_PASS
EOF

fi

#cat /etc/ssmtp/ssmtp.conf
echo "Generated config with target $SSMTP_SERVER:$SSMTP_PORT"

printf "From: %s\nSubject: %s\n\n%s" "$SSMTP_FROM" "$SSMTP_SUBJECT" "$SSMTP_MESSAGE"  > mail.txt

echo "Sending mail to $SSMTP_FROM"
ssmtp "$SSMTP_TO" < mail.txt
echo "Sent mail to $SSMTP_FROM"
