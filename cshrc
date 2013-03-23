# $FreeBSD: release/9.0.0/etc/root/dot.cshrc 170088 2007-05-29 06:37:58Z dougb $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
#

alias h		history 25
alias j		jobs -l
alias la	ls -a
alias lf	ls -FA
alias ll	ls -lA
alias lg	ls -Gla
alias ls	ls -Gla
alias cp	cp -r

# A righteous umask
umask 22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin /usr/local/kde4/bin $HOME/bin)

setenv	EDITOR	vim
setenv	PAGER	more
setenv	BLOCKSIZE	K

if ($?prompt) then
	# An interactive shell -- set some stuff up
	set prompt = "[`whoami`@%~]"
	set filec
	set autolist
	set history = 4096
	set savehist = 4096
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif
endif

setenv PACKAGESITE "http://mirrors.tuna.tsinghua.edu.cn/freebsd/ports/i386/packages/Latest/"
setenv LANG en_US.UTF-8
setenv XMODIFIERS @im=fcitx
setenv GTK_IM_MODULE xim
setenv QT_IM_MODULE xim
if ("rxvt" == $term) then
	bindkey "\e[3~" delete-char
endif
