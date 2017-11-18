# .emacs.d

This contains my personal Emacs configuration.

It's written as an Org-Mode file and the best way to look at it is to browse [config.org](config.org) on Github.

## How to use it

### Initial cloning of the directory

Clone it into the right directory either `/home/user/` under Linux / Mac or into the `portable-emacs-win64` directory under Windows.

    git clone https://github.com/dahanbn/.emacs.d.git

### Pushing updates to the master

    git add config.org
    git commit -m "info about the commit content"
    git push

### Pulling updates from master

    git pull
	
### Handling local conflicts

#### Ignore them and do a hard reset

    git reset --hard HEAD

#### Checkout the changed files ??

    git status
	git checkout -- FILENAME
