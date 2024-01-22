handlers and pipes

### ago 22

https://github.com/aaronamk/scripts/blob/main/omni-open.sh

```
#!/bin/sh
# Author: aaronamk
# simpler, easier, and faster than xdg-open

[ "$1" ] || exit # exit if no file provided

ext=$(printf "$1" | rev | cut -d "." -f 1 | rev | tr '[:upper:]' '[:lower:]')
case "$ext" in
  "raw")  setsid imv         "$1" ;;
  "png")  setsid imv         "$1" ;;
  "jpg")  setsid imv         "$1" ;;
  "jpeg") setsid imv         "$1" ;;
  "gif")  setsid imv         "$1" ;;
  "bmp")  setsid imv         "$1" ;;
  "tiff") setsid imv         "$1" ;;
  "wav")  mpv                "$1" ;;
  "flac") mpv                "$1" ;;
  "opus") mpv                "$1" ;;
  "ogg")  mpv                "$1" ;;
  "mp3")  mpv                "$1" ;;
  "m4a")  mpv                "$1" ;;
  "mp4")  setsid mpv         "$1" ;;
  "avi")  setsid mpv         "$1" ;;
  "mov")  setsid mpv         "$1" ;;
  "flv")  setsid mpv         "$1" ;;
  "mkv")  setsid mpv         "$1" ;;
  "wmv")  setsid mpv         "$1" ;;
  "webm") setsid mpv         "$1" ;;
  "pdf")  setsid zathura     "$1" ;;
  "odt")  setsid libreoffice "$1" ;;
  "docx") setsid libreoffice "$1" ;;
  "html") setsid firefox     "$1" ;;
  "gz")   setsid file-roller "$1" ;;
  "tar")  setsid file-roller "$1" ;;
  "zip")  setsid file-roller "$1" ;;
  "gzip") setsid file-roller "$1" ;;
  "7z")   setsid file-roller "$1" ;;
  "rar")  setsid file-roller "$1" ;;
  *)      [ "$(file -b $1)" = "directory" ] && vifm "$1" || nvim "$1" ;;
esac

```
### dec 21

lots of simple newsboat handlers, https://github.com/T3SQ8/dotfiles/blob/master/bin/.local/bin/openfeed-default

### sep 21



https://github.com/khonsaloh/dots/
for newsboat

````

#!/bin/sh

# Feed script a url or file location.
# If an image, it will view in sxiv,
# if a video or gif, it will view in mpv
# if a music file or pdf, it will download,
# otherwise it opens link in browser.

# If no url given. Opens browser. For using script as $BROWSER.
[ -z "$1" ] && { "$BROWSER"; exit; }

case "$1" in
	*mkv|*webm|*mp4|*youtube.com/watch*|*youtube.com/playlist*|*youtu.be*|*hooktube.com*|*bitchute.com*|*videos.lukesmith.xyz*)
		setsid -f mpv -quiet "$1" >/dev/null 2>&1 ;;
	*png|*jpg|*jpe|*jpeg|*gif)
		curl -sL "$1" > "/tmp/$(echo "$1" | sed "s/.*\///;s/%20/ /g")" && sxiv -a "/tmp/$(echo "$1" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*pdf|*cbz|*cbr)
		curl -sL "$1" > "/tmp/$(echo "$1" | sed "s/.*\///;s/%20/ /g")" && zathura "/tmp/$(echo "$1" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*mp3|*flac|*opus|*mp3?source*)
		qndl "$1" 'curl -LO'  >/dev/null 2>&1 ;;
	*)
		[ -f "$1" ] && setsid -f "$TERMINAL" -e "$EDITOR" "$1" >/dev/null 2>&1 || setsid -f "$BROWSER" "$1" >/dev/null 2>&1
esac
````




### may 21 more "linkhandlers

[dotfiles/weblauncher at master · azimut/dotfiles](https://github.com/azimut/dotfiles/blob/master/homedir/bin/weblauncher)

### jan 21 gotbletu urlportal

https://github.com/gotbletu/dotfiles_v2/blob/master/normal_user/scripts/.scripts/urlportal

### ago20 newsboat linkhandler (for macro links also)


https://github.com/nsklaus/dotfiles/blob/master/.local/bin/linkhandler

````
#!/bin/sh

# Feed script a url or file location.
# If an image, it will view in sxiv,
# if a video or gif, it will view in mpv
# if a music file or pdf, it will download,
# otherwise it opens link in browser.

# If no url given. Opens browser. For using script as $BROWSER.
[ -z "$1" ] && { "$BROWSER"; exit; }

case "$1" in
	*mkv|*webm|*mp4|*youtube.com/watch*|*invidio.us/watch*|*youtube.com/playlist*|*youtu.be*|*hooktube.com*|*bitchute.com*)
		setsid -f mpv -quiet "$1" >/dev/null 2>&1 ;;
	*png|*jpg|*jpe|*jpeg|*gif)
		curl -sL "$1" > "/tmp/$(echo "$1" | sed "s/.*\///")" && sxiv -a "/tmp/$(echo "$1" | sed "s/.*\///")"  >/dev/null 2>&1 & ;;
	*mp3|*flac|*opus|*mp3?source*)
		setsid -f tsp curl -LO "$1" >/dev/null 2>&1 ;;
	*)
		if [ -f "$1" ]; then "$TERMINAL" -e "$EDITOR" "$1"
	else setsid -f "$BROWSER" "$1" >/dev/null 2>&1; fi ;;
esac
````





how to execute macro on a specific link ? · Issue #1118 · newsboat/newsboat
https://github.com/newsboat/newsboat/issues/1118

````
browser linkhandler
macro , open-in-browser
macro t set browser "qndl" ; open-in-browser ; set browser linkhandler
macro a set browser "tsp youtube-dl --add-metadata -xic -f bestaudio/best" ; open-in-browser ; set browser linkhandler
macro v set browser "setsid -f mpv" ; open-in-browser ; set browser linkhandler
macro w set browser "lynx" ; open-in-browser ; set browser linkhandler
macro p set browser "dmenuhandler" ; open-in-browser ; set browser linkhandler
macro c set browser "xsel -b <<<" ; open-in-browser ; set browser linkhandler
macro C set browser "youtube-viewer --comments=%u" ; open-in-browser ; set browser linkhandler
macro d set browser "curl -LO %u" ; open-in-browser ; set browser linkhandler
````

### jul2020 gotbletu 'urlportal'

https://github.com/gotbletu/shownotes/blob/master/urlportal.sh

### apr2020 drew



Managing my dotfiles as a git repository | Drew DeVault’s Blog
https://drewdevault.com/2019/12/30/dotfiles.html

```
#!/bin/sh
case "${1%%:*}" in
	http|https|*.pdf)
		exec qutebrowser "$1"
		;;
	mailto)
		exec aerc "$1"
		;;
	*)
		exec /usr/bin/xdg-open "$@"
		;;
esac
```

Replacing the needlessly annoying-to-customize xdg-open with one that just does what I want, falling back to /usr/bin/xdg-open if necessary. Many other non-shadowed scripts and programs are found in ~/bin as well.




Mon Jan 22 03:26:15 AM WET 2024
