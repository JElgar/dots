# dots

Jelgar's dot files.

## Install

https://www.atlassian.com/git/tutorials/dotfiles

`alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

Clone the repo

`git clone --bare git@github.com:JElgar/dots.git $HOME/.dotfiles`

Checkout the content 
```bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config checkout
```

If issues then use this to backup current config files

```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

config checkout
```

Then run 
```
config config --local status.showUntrackedFiles no
```
