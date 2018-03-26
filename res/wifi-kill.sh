#!/bin/bash

check_root() {
  if [ "$EUID" -ne 0 ];
  then
    echo "Please run this script as using sudo/as root, otherwise it can't continue."
    exit
  fi
}

find_and_kill() {
  PID=$(ps aux | grep "$1" | grep -v grep | grep -v sudo | awk '{print $2}')
  CMD=$(ps aux | grep "$1" | grep -v grep | grep -v sudo | awk '{print $11}')
  if [ ! -z "$PID" ];
  then
    echo "Killing $CMD with PID:$PID"
    #kill "$PID"
    sudo kill "$PID"
  else
    echo "No process '$1' found"
  fi
}

#check_root
find_and_kill journalctl
find_and_kill miracle-wifid
