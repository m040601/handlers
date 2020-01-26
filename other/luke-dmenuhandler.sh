#!/usr/bin/env sh
# Feed this script a link and it will give dmenu
# some choice programs to use to open it.

case "$(printf "copy url\\nmpv\\nmpv (loop)\\nqueue download\\n\\nqueue youtube-dl\\nfeh\\nbrowser\\nw3m\\nmpv (float)" | dmenu -i -p "Open link with what program?")" in
	"copy url") echo "$1" | xclip -selection clipboard ;;
	mpv) setsid mpv -quiet "$1" >/dev/null 2>&1 & ;;
	"mpv (loop)") setsid mpv --input-ipc-server=/tmp/mpvsoc$(date +%s) -quiet --loop "$1" >/dev/null 2>&1 & ;;
	"queue download") tsp curl -LO "$1" >/dev/null 2>&1 ;;
	"queue youtube-dl") tsp youtube-dl --write-metadata -ic "$1" >/dev/null 2>&1 ;;
	browser) setsid "$BROWSER" "$1" >/dev/null 2>&1 & ;;
	feh) setsid feh "$1" >/dev/null 2>&1 & ;;
	w3m) w3m "$1" >/dev/null 2>&1 ;;
	"mpv (float)") setsid mpv --input-ipc-server=/tmp/mpvsoc$(date +%s) --geometry=+0-0 --autofit=30%  --title="mpvfloat" "$1" >/dev/null 2>&1 & ;;
esac
