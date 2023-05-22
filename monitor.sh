#!/bin/sh

FAN_INPUT=$(ls /sys/class/hwmon/hwmon?/fan1_input)

fanspeed() {
    expr 5000 - $(cat $FAN_INPUT)
}

TEMP=/sys/devices/virtual/thermal/thermal_zone0/temp

soctemp() {
    echo $(( ( $(cat $TEMP) + 500 ) / 1000 ))
}

N=${1:-30}

while :; do
    echo $( date "+%F %T"
            fanspeed
            soctemp
            hddtemp -n /dev/sda /dev/sdb
          )
    sleep $N
done
