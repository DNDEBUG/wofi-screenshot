#!/bin/sh

name=$(date +%Y-%m-%d_%I:%M:%S-$RANDOM)
outfile=~/Imagens/screenshots/$name.png
program=`wofi -d -n -b -L 3 -- << EOF
selection
screen
window
EOF`

case $program in
	selection)
		grim -g "$(slurp)" -t png -l 9 $outfile && dunstify "Saved: $name" ;;
	screen)
		grim -t png  -l 9 $outfile && dunstify "Saved: $name" ;;
	window)
		grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" -t png -l 9 $outfile && dunstify "Saved: $name" ;;
esac
