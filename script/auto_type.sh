#!/run/current-system/sw/bin/bash

get_copy_text="$(wl-paste)"
sleep 1
ydotool type -e=0 -D 1 -H 1 -d 0 "$get_copy_text"
