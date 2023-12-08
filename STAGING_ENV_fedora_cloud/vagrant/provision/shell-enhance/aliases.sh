#!/usr/bin/env bash
#### DEPRECATED ####

#### END ## DEPRECATED ####

#### GENERAL PURPUSE ####
## Used to list better all aliases - instead of alias
alias aliases='acs' 

#### END ## GENERAL PURPUSE ####

#####Try-to substitute command's use###
# find --> fd-find
# df   --> duf
# du   --> ncdu
# cat  --> bat
# ls   --> exa
#
#
## ADVANCED:
# wget -> curl -> http (from HTTPie)

## OTHER (DEPRECATED, due to no maintenance for a long time):
# arp → ip n (ip neighbor)
# ifconfig → ip a (ip addr), ip link, ip -s (ip -stats)
# iptunnel → ip tunnel
# iwconfig → iw
# nameif → ip link, ifrename
# netstat → ss, ip route (for netstat -r), ip -s link (for netstat -i), ip maddr (for netstat -g)

## Short "man" pages
# tldr  <term>
# cheat <term>
# curl cht.sh/<term> <-> cht.sh is the webpage with the info (check the GitHub of the proj)
##END##Try-to substitute command's use###

# alias ls='ls -F -X -B -T 0 --color=tty'
alias ll='grc ls -Alg --color=always'
alias lll='grc ls -Al "--time-style=+%Y-%m-%d %H:%M:%S %4Z" --color=always'

# FILES and FILE LOCATIONS 
alias l='grc --colour=on ls -Fax --color=always'
alias lt='grc --colour=on ls -lahtF --color=always "--time-style=+%Y-%m-%d %H:%M:%S %4Z"'
alias la='grc --colour=on ls -lahF --color=always --group-directories-first'

## local dir lg (list and grep)
alias lg='grc --colour=on ls -lahF --color=always | grep -iE'
## global dir lg
function lg_global_fn(){ grc --colour=on ls -lahF "$1" | grep -iE --color=always "$2"; }
alias lgg=lg_global_fn

# improved ls --> using exa
alias lo='exa -lahg --group-directories-first --git'

# The next two can (most of the time) complain that there's no '..?' file
#alias l.='ls -d .{.?,[^.]}* --color=tty'
# NB: .? means a dot and any character after that, one!
alias l.='grc --colour=on ls -d .[^.]* ..?* --color=tty 2>/dev/null'
#alias l.='ls -d .[!.]* ..?* --color=tty 2>/dev/null'
#echo .[!.]* ..?* *


# MISC
# which
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

# Subversion
alias svnign='svn propedit svn:ignore "$@"'

# color grep
alias grep='grep --color=always'
# color less (restricted)
alias less='less -R'

## PRIVATE Custome Location:
#FIXME: #alias bash_hist_grep_extract='awk '{split($0,arr,":"); print arr[2]}'| awk'{gsub(/^[ \t]+|[ \t]+$/, ""); print }' | sort | uniq -u'
## PRIVATE end

## SHELL-DEV-PROCs sh/bash/zsh environment-related querries:
# DEFINITION: querries of default variables into the current shell environment
#FIXME: # compgen -A variable | grep -vE "^[A-Z]|^_|^new_|^my_|colors"
# NOTE: read the man compgen and the fallowing (*complete* option definition apply to compgen as well)

# COLORING using GRC (as it doesn't color these apps by default)
alias ss='grc ss'
alias ip='grc ip'
alias df='grc df'
alias ping='grc ping'
alias dig='grc dig'
alias ps='grc ps'
alias traceroute='grc traceroute'
alias iptables='grc iptables'
alias lsblk='grc lsblk'
alias fdisk='grc fdisk'

# COLORING using BAT (bat is advanced less substitute that has -l option for languages such as man,json,etc...)
# This is done only once and is NOT part of alias calling: export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# DNF specific
# alias dnfs="dnf search $@[0]| grep -iE" - think about how to insert
alias dnfs='dnf search'
alias dnfi='sudo dnf install'
alias dnfiy='sudo dnf install -y'
## Add to the exclude (space separated) argument list the packages you don't want to be updated
alias dnfuy='sudo dnf update --exclude="opera-stable" -y'

# FULL-SYSTEM UPDATE
function update_all()
{
	echo '\r\n	--> check available rpm-packages for update	\r\n'
	dnf check-update

	echo '\r\n	--> Are there KERNEL-mods to update? -->	\r\n'
	dnf check-update | grep -iE "kernel"

	echo '\r\n	--> dnf update without kernel	\r\n'
	sudo dnf update --exclude="kernel-*"

	echo '\r\n	--> flatpak update	\r\n'
	flatpak update -y

	echo '\r\n	--> zplug update	\r\n'
	zplug update

	echo '\r\n	--> omz update and refresh	\r\n'
	omz update
	omz reload
}

# SSH login scpecific
alias ssh@vhs='ssh -AYv admin@vhs '

# sudo alias-ing : Bash only checks the first word of a command for an alias, any words after that are not checke    d. That means in a command like sudo ll, only the first word (sudo) is checked by bash for an alias, ll is ignore    d. We can tell bash to check the next word after the alias (i.e sudo) by adding a space to the end of the alias v    alue
alias sudo='sudo '
# Problem with 'sudo(alias ) vim'
# The problem is fixed/patched in the example for .bashrc and has its versions in the .zshrc respectively
# Check the README.md

#For Fedora X11 to have vim with copy to clipboard from vim with "+y functionality we need package named vim-X11
# NOW we can do, alias vim='vimx', so we can use +clipboard and +xterm_clipboard active options... YES, but NO since the last alias settings loaded are the ones from the Current User's .zshrc/.bashrc(respectivelt) so the alias should be there duo to the option of "unalias" we use to solve another problem
# ref: https://sophieau.com/article/how-to-get-the-system-clipboard-working-in-vim-on-fedora/

# TOOLBOX 
alias tbe='toolbox enter '
alias tbr='toolbox run '


# GENERIC
function package_search(){
	echo '---dnf search---'
	dnf search $1;
	echo '---flatpak/flathub searh---'
	flatpak search $1;
	echo '---brew/homebrew search---'
	brew search $1;
	echo '---npm/js search---'
	npm search $1;
#	echo '---pip search---'
#	pip search $1;
}


# DOCKER
alias dm="docker-machine"
