#!/run/current-system/sw/bin/bash

get_copy_text="$(wl-paste)"
sleep 1
ydotool type -e=0 -d 20 "$get_copy_text"
