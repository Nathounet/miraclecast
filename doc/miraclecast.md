#nMiracleCast

### Run MiracleCast as sink
* Kill wpa_supplicant and NetworkManager to allow miracle-wifid to create a wifi-p2p interface. Run in miraclecast/res/
```
./kill-wpa.sh
```

* In verbose mode with log creation:
```
sudo journalctl -f |& tee journal.log &
sudo miracle-wifid --log-level trace |& tee wifid.log &
sudo miracle-sinkctl --log-level trace --log-journal-level trace -e miracle-vlc |& tee sink.log
```
* Otherwise:
```
sudo miracle-wifid --log-level info &
sudo miracle-sinkctl --log-level info
```
* Then enter "run #" with # the number of the link detected
* Connect phone or laptop via Miracast/MirrorShare/Wireless Display

### Exit and restore default wifi connection
"quit" to exit miracle-sinkctl. Then in miraclecast/res/:
* kill miracle-wifid process by running wifi-kill.sh
* run normal-wifi.sh to restore default interface (restart wpa_supplicant)



### Create callgraph when building with autotools
(you may need to install some other bin and libraries: autoconf, libtool, egypt...)
```
../autogen.sh g
make CFLAGS="-g -fdump-rtl-expand"
```
Navigate to build dir, you'll see the \*.expand files
```
egypt *.expand | dot -Tsvg -o cmp_callgraph.svg
```
