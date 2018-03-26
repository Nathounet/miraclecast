#!/bin/sh

./kill-wpa.sh
./wifi-kill.sh
echo "Launching MiracleCast"
if [ "$#" = 1 ];
then
  LOGDIR=log-$(date "+%Y.%m.%d-%H.%M.%S")
  echo "The logs will be written in \"$LOGDIR\" with log-level \"$1\""
  mkdir "$LOGDIR"
  sudo journalctl -f 2>&1 | tee "$LOGDIR"/journal.log &
  sudo miracle-wifid --log-level "$1" 2>&1 | tee "$LOGDIR"/wifid.log &
  sleep 2
  sudo miracle-sinkctl --log-level "$1" --log-journal-level "$1" 2>&1 | tee "$LOGDIR"/sink.log
elif [ "$#" = 0 ];
then
  sudo miracle-wifid &
  sleep 2
  sudo miracle-sinkctl --res 17000,00,00
else
  echo "Please run ./launch.sh [info|debug|trace]"
  exit
fi
echo "Ending MiracleCast"
./wifi-kill.sh
