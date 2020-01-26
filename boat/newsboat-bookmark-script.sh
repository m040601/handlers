#!/bin/sh
# bookmark-cmd "~/bin/delicious-bookmark.sh"
# https://raw.githubusercontent.com/uriel1998/newsbeuter-dangerzone/master/bookmarks


# Use this template to fix up all your ifttt triggers as well... just send via e-mail.

url="$1"
title="$2"
description="$3"
# is 'feed' valid ?
feed="$4"

# trimming length of title so it's tweetable!
if [ ${#title} -gt 109 ]; then
    short_title=`echo "$title" | awk '{print substr($0,1,110)}'`
else
    short_title="$title"
fi

# Requires a slightly modified version of 
# https://gist.github.com/uriel1998/3310028
# which only returns the shortened URL.
shorturl=`bitly.py "$url"`

case "$description" in 
    [tT][wW]*)
        #twitter - requires oysttyer
        #https://github.com/oysttyer/oysttyer
        szAnswer=`echo "$short_title: $shorturl"`
        perl ttytter.pl -silent -status="$szAnswer"
    ;;
    [Ss][Oo][Cc]*)
        #twitter - requires oysttyer
        #https://github.com/oysttyer/oysttyer        
        #uses this IFTTT script
        #https://ifttt.com/applets/112202p-post-your-tweets-to-facebook-when-you-use-a-specific-hashtag
        szAnswer=`echo "$short_title: $shorturl #fb"`
        perl ttytter.pl -silent -status="$szAnswer"
    ;;
    [pP][oO][Cc]*)
        # I hate dealing with API OAuth for something as simple as adding a freaking link.
        # Send to e-mail DONE.
        #http://help.getpocket.com/customer/portal/articles/482759
        echo "$url" | mutt -s "$short_title" add@getpocket.com
        notify-send --icon=notification-network-wireless-full "Sent to Pocket"
    ;;
    #BUFFER: Send to email using http://bufferapp.com/guides/email
    [Bb][uU][Ff]*)
        echo "$url" | mutt -s "$short_title" buffer-BLAHBLAHBLAH@to.bufferapp.com
        notify-send --icon=notification-network-wireless-full "Mailed to Buffer"
    ;;

    #REMEMBER THE MILK: Send to RTM via email: https://www.rememberthemilk.com/services/email/
    [Rr][Tt][Mm]*)
        echo -e "U: $url\nS: RSS\n-end-" | mutt -s "$short_title" username+abc123@rmilk.com
        notify-send --icon=notification-network-wireless-full "Sent to RTM"
    ;;
    
    *) 
        # echo "${url}\t${title}" >> ~/bookmarks.txt
        # echo "${url}\t${title}" >> ~/.newsboat/newsboat-bookmarks.txt
        # echo -e "${url}\t${title}" >> ~/.newsboat/newsboat-bookmarks.txt
        # echo -e "${url}\n${title}" >> ~/.newsboat/newsboat-bookmarks.txt
        # echo -e "${title}\n${url}\n\n" >> ~/.newsboat/newsboat-bookmarks.txt
	echo -e "${feed}\n${title}\n${url}\n${description}\n\n" >> ~/.newsboat/Newsboat_bookmarks/latest-newsboat-bookmarks.txt
        notify-send --icon=notification-network-wireless-full "Saved to URL List"       
    ;;
esac





# 
# factory
# 
#  #!/bin/sh
#  url="$1"
#  title="$2"
#  description="$3"
#  echo -e "${title}\n<${url}>\n${description}\n\n" >> ~/TODO.rss-bookmarks.txt


#
# mail list
#
#     Is there a way to yank the url from an article to the clipboard? At the moment
#     I'm sneaking this functionality in via the `bookmark-plugin.sh
#     This works, but maybe I don't always want to save the info.
#     
#     
#     # factory printf
#     os=$(name)
#     if [[ ${os} == "Darwin" ]]; then
#          printf "%s\t%s\t%s\t%s" \
#              "${url}" \
#              "${title}" \
#              "${description}" \
#              "${feed_title}" >> ~/Nextcloud/bookmarks.txt
#          echo "${url}" | pbcopy
#     fi
#     
#     
#     You can change the `browser` variable to point to the script, open the 
#     article, and reset the variable back afterwards: 
#     
#     macro o set browser "/path/to/your/script.sh"; open-in-browser; set browser "/usr/bin/firefox" 
#     
#     The script should accept the URL as its first argument: 
#     
#     #!/bin/sh 
#     url="$1" 
#     echo "$url" | pbcopy 
#     
#     If you need to access some URL that's *inside* an article, your best bet 
#     is an external URL viewer. I haven't used any such programs, so can't 
#     recommend anything in particular, let alone tell you if any of them 
#     enable you to copy the URL to the clipboard. But you're welcome to try 
#     them out by changing the external-url-viewer setting: 
#     https://newsboat.org/releases/2.14.1/docs/newsboat.html#external-url-viewer 
#     
#     Regards, 
#     Alexander Batischev 
#     
#     
#     
#     
#     
#     
#     
#     
#     I am trying to create a macro that will allow me to remove a url from the urls file.
#     I have tried sed, awk, and grep. 
#     I am able to make them all work outside newsboat but can get them to work when I run the macro.
#     Is the urls file locked while newsboat is running? 
#     Or do I have the syntax wrong?
#     
#     Here's what I have tried. 
#                
#     macro r set browser "sed -i '\|%u|d' /home/pi/snap/newsboat/682/.newsboat/urls"; open-in-browser ; set browser "w3m"; reload-urls 
#                                             
#     macro r set browser "sed -i 's|%u||' /home/pi/snap/newsboat/682/.newsboat/urls"; open-in-browser ; set browser "sed -i '/^$/d' /home/pi/snap/newsboat/682/.newsboat/ur    ls"; open-in-browser ; set browser "w3m"; reload-urls    
#     
#     macro y set browser "sed -i '/^$/d' /home/pi/snap/news    boat/682/.newsboat/urls"; open-in-browser ; set browser "w3m"; reload-urls                                        
#     
#     macro r set browser "awk '!/%u/' /home/pi/snap/newsboat/682/.newsboat/urls > ./temp && mv ./temp /home/pi/snap/newsboat/682/.newsboat/urls"; open-in-browser ; set browser "w3m"; reload-urls                                    
#     
#     macro r set browser "/home/pi/snap/newsboat/682/.newsbo    at/remove_url %u"; open-in-browser ; set browser "w3m"; reload-urls
#     
#     I also tried running these from a bash script without any luck.
#     
#     Any suggestions on how to accomplish this?
#     
#     Thanks
#     
#     ANSWER
#     
#     >macro r set browser "sed -i '\|%u|d' 
#     >/home/pi/snap/newsboat/682/.newsboat/urls"; open-in-browser ; set 
#     >browser "w3m"; reload-urls 
#     
#     This approach is perfectly correct. What trips it is that Newsboat puts 
#     the URL in single quotes, so the command becomes `sed -i 
#     '\|'https://example.com'|d' path`. This clearly won't work. 
#     
#     The easiest workaround I know is to put the command in the script, like 
#     this: 
#     
#         #!/bin/sh 
#     
#         url="$1" 
#         sed -i "\|${url}|d" /home/pi/snap/newsboat/682/.newsboat/urls 
#     
#     Store it in /home/pi/snap/newsboat/682/.newsboat/remove-url, and change 
#     your config as follows: 
#     
#         macro r set browser "/home/pi/snap/newsboat/682/.newsboat/remove-url %u"; open-in-browser ; set browser "w3m"; reload-urls 
#     
#     I tested this, and it works that way. You mention you tried putting the 
#     command in a script already and it didn't work; perhaps your script was 
#     a bit different from mine? 
#     
#     There is a second pitfall to be aware of: you need to reload the feed at 
#     least once for that macro to work. If you don't, Newsboat will pretend 
#     it doesn't know the URL, and will call the script with an empty string 
#     as an argument. 
#     
#     
#     As it turns out, neither of these details are documented. I'll update 
#     the docs now. Sorry you had to learn them the hard way. 
#     
#     
#     
