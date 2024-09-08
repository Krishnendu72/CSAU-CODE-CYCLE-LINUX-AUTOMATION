#!/bin/bash

LOWERCASE_THRESHOLD=1
LOGFILE="/var/log/sudo-access.log"

ends_with_sh() {
    [[ "$1" =~ SH$ ]]
}

has_capital_letters() {
    [[ "$1" =~ [A-Z] ]]
}

USERS=$(awk -F':' '$3 >= 1000 { print $1 }' /etc/passwd)

for USER in $USERS
do
    SUDO_ATTEMPTS=$(grep "$USER" $LOGFILE | grep -c "sudo")

    if ends_with_sh "$USER"; then
        echo "$USER has unlimited sudo access attempts."
    elif ! has_capital_letters "$USER"; then
        if [ "$SUDO_ATTEMPTS" -gt "$LOWERCASE_THRESHOLD" ]; then
            echo "Threshold reached for $USER"
            echo "Threshold reached for $USER" | mail -s "Alert: Sudo Attempts" krishnenduis19@gmail.com
        fi
    fi
done
