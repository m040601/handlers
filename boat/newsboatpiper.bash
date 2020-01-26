#!/usr/bin/env bash
#
# ??? who ??? cirrus
# https://github.com/newsboat/newsboat/issues/23
# http://arza.us/paste/piper

#
# newsboatpiper.bash
# If you use weechat-curses or irssi it also works well when you set the script
# as the terminal emulators browser.
# youtube urls and more will auto open in mpv, all hyperlinks and local files
# ending in .jpg, .png etc will open in feh.
# A function containing a case list of options 
open() {
    case "$1" in
        *youtube.com*|*youtu.be*|*vodlocker.com*|*.webm*|*.mp4*|*.avi)  mpv "$1";;
        # *.PNG|*.JPG|*.png|*.jpeg|*.gif*|*.jpg) feh -. "$1";;  # feh -. = opens to fit window.
	# wordpress images
        *.PNG|*.JPG|*.png|*.jpeg|*.gif*|*.jpg|*.png??????|*.jpeg??????|*.gif??????|*.jpg??????) feh -. "$1";;  # feh -. = opens to fit window.
        # *) firefox "$1";  # For everything else.;
        *) elinks -remote  "$1";  # For everything else.;
    esac
}
# Now a for loop to iterate the list of options, 
for url; do
    open "$url"
done



# factory recomendation 
#browser "~/bin/newsboat-browser.sh"
#    #/bin/sh
#    /usr/bin/firefox "$@" &
#    $ chmod +x ~/bin/newsboat-browser.sh
