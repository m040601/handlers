handlers and pipes

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




