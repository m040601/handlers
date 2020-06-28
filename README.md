handlers and pipes

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




