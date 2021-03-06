# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running in
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

for f in ~/.func/*; do 
	source $f
done

export GO111MODULE=on
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

source <(kubectl completion bash)

#k8s alias
alias k='kubectl'
complete -F `complete  | grep "kubectl" | awk '{print $7}'` k
alias kpa='k get pods --all-namespaces'
alias kpn='k get pods -n'
alias kps='k get pods -n kube-system'
alias kpd='k get pods'
alias knp='k get nodes -l "primaryPeer=true" -o wide'
alias knpip='k get nodes -l "primaryPeer=true" -o jsonpath='"'"'{ $.items[*].status.addresses[?(@.type=="InternalIP")].address }'"'"
alias kna='k get nodes'
alias kok='kubeauth'
alias kt='kok -t'
alias kw='--watch'

alias k8secret='echo $1 | base64 --decode'

alias kswitch="kubectl config use-context $1"
alias kcurr="k config current-context"
alias knamespace="k config set-context $(kcurr) --namespace $1"

alias kccp="pbpaste | k create -f -"

alias tf="terraform"
alias tg="terragrunt"

#general alias
alias rm='rm -v'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias editrc='vi ~/.bashrc && source ~/.bashrc'

#alias ide='open $1 -a /Applications/IntelliJ\ IDEA.app/'
alias ide='open $1 -a /Applications/GoLand.app/'
alias sublime='open $1 -a /Applications/Sublime\ Text.app/'


alias project='cd ~/project && cd $1'

