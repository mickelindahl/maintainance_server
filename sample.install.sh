#!/bin/bash

if [ ! $USER==root ]; then
    echo "Please run as root"
    exit
fi

CRON_FILE="maintainace-server-cron"

touch $CRON_FILE

LOG_PATH=$(pwd)"/log"

# Restart docker daemon Every saturday at 23:05
echo '5 23 * * SAT root /usr/sbin/service docker restart && echo "$(date +"\%m-\%d-\%y \%H:\%M") service docker restart" >> '$LOG_PATH' 2>&1' > $CRON_FILE

# Restart server every first saturday of the month at 23:00
echo '0 23 1-7 * * root [ "$(date '+\\%a')" = "Sat" ] && echo "$(date +"\%m-\%d-\%y \%H:\%M") reboot" >> '$LOG_PATH' 2>&1 && /sbin/reboot' >> $CRON_FILE

echo "Move $CRON_FILE to /etc/cron.d"
chown root:root $CRON_FILE
chmod 644 $CRON_FILE
mv $CRON_FILE /etc/cron.d/

