## history
export HISTCONTROL="ignorespace:erasedups:ignoredups"
export HISTSIZE=10000
export HISTIGNORE="?:??:???:history:cd ~:cd -:cd ..:tree:clear:echo:exit:git ??:git ???:git ????:git ?????:git status:git unstash::lyrics:mpsyt:music:ncmcpp:weechat:mutt:turses:bugwarrior-pull:t *:task *:mktemp:mount:alias:keybase:pass *:wifipass *:wormhole:* wormhole:wormhole *:clip2worm:worm2clip:ipython:calc *:* --help:* -h:* help:help *:apropos *:man *:tldr *:what *:whatis *:which *:*tmux new-session -A -s DEV *:python:python3:python2:python2.7:make:deactivate:lsvirtualenv:workon *:date:reset:glances:htop:ifconfig:mount:myip:netstat:nettop:sysinfo:systop:vnstat:nimble:nimble ??:ssh-keygen*:exterminate_ds_store:lskites:suspend"

# Bind arrow to search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

## completions
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi
if [ -d /usr/local/etc/bash_completion.d ]; then
    for _FILE in `ls /usr/local/etc/bash_completion.d`; do
        . "/usr/local/etc/bash_completion.d/$_FILE"
    done
fi
if [ -d "$HOME/.local/share/bash-completion" ]; then
    for _FILE in `ls "$HOME/.local/share/bash-completion"`; do
        . "$HOME/.local/share/bash-completion/$_FILE"
    done
fi

## colors
#define ls/tree coloring
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LSCOLORS="exfxcxdxbxegedabagacad"
# tell ls to be colourful
export CLICOLOR=1
# tell grep to highlight matches
export GREP_OPTIONS='--color=auto'
# Colors to use in bash
export BLACK='\033[0;30m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export ORANGE='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT_GRAY='\033[0;37m'
export GRAY='\033[1;30m'
export LIGHT_RED='\033[1;31m'
export LIGHT_GREEN='\033[1;32m'
export YELLOW='\033[1;33m'
export LIGHT_BLUE='\033[1;34m'
export LIGHT_PURPLE='\033[1;35m'
export LIGHT_CYAN='\033[1;36m'
export WHITE='\033[1;37m'
export NC='\033[0m' # No color

# bash prompt
PROMPT_DIRTRIM=2
if [ -f "$HOME/.bash_theme" ];then
    . "$HOME/.bash_theme"
fi

## aliases
alias backup='function __backup() { cp -R $1 $1.bak; }; __backup'
alias bak='backup'
alias c=clear
alias calc='bc -l <<<'
alias clip2worm='pbpaste | wormhole send --text -'
alias exterminate_ds_store='find ~/ -d -maxdepth 100 -name ".DS_Store" -type f -print -delete'
alias k='kubectl'
alias kns='kubectl config set-context `kubectl config current-context` --namespace'
alias l='ls -FG'
alias la='ls -aG'
alias ll='ls -lG'
alias ls='ls -FG'
alias lskites='ps aux | awk '"'"'/pagekite/ && !/awk/ {print $2"\t"$1"\t"$NF}'"'"
alias lyrics='lyvi'
alias mf='mkdir -p'
alias music='ncmpcpp'
alias myip="wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias nipgen='pwgen -A -s -r abcdefghijklmnopqrstuvwxyz'
alias q=exit
alias realpath='function __realpath() { echo $(cd $(dirname "$@"); pwd)/$(basename "$@"); }; __realpath'
alias rf='rm -rf'
alias sha1sum='shasum'
alias sha256sum='shasum -a 256'
alias sl='ls'
alias suspend='pmset sleepnow'
alias swap='function __swap() { TMP=`mktemp`; mv $1 $TMP; mv $2 $1; mv $TMP $2; }; __swap'
alias sysinfo='screenfetch 2>/dev/null'
alias systop='glances'
alias t='task'
alias tldr='tldr -p osx'
alias unbackup='function __unbackup() { mv -i $1 ${1%.bak}; }; __unbackup'
alias unbak='unbackup'
alias urldecode='function __urldecode() { local url_encoded="${1//+/ }"; printf '"'%b'"' "${url_encoded//%/\\x}"; }; __urldecode'
alias urlencode='function __urlencode() { local LANG=C i c e=""; for ((i=0;i<${#1};i++)); do c=${1:$i:1}; [[ "$c" =~ [a-zA-Z0-9\.\~\_\-] ]] || printf -v c '"'%%%02X'"' "'"'"'$c"; e+="$c"; done; echo "$e"; }; __urlencode'
alias vi='vim'
alias wifipass='function __wifipass() { security find-generic-password -ga "$1" | grep "password:"; }; __wifipass'
alias worm2clip='wormhole receive | tee >(cut -d" " -f5- | pbcopy)'
alias ws='cd ${WORKSPACE_HOME}'
alias dots='yadm'
alias yt='mpsyt'

# Completion for aliases
complete -o bashdefault -o default -F _yadm dots
complete -o nospace -F _task t
complete -o default -F __start_kubectl k

## Env vars
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## Lesspipe
export LESSOPEN='|$(which lesspipe.sh) %s'
export LESS_ADVANCED_PREPROCESSOR=1

export EDITOR='vim'
# export BROWSER='firefox'

## brew sqlite3
export PATH="/usr/local/opt/sqlite/bin:$PATH"

## brew python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

## virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=`which python2`
export WORKON_HOME="$HOME/.virtualenvs"
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    . /usr/local/bin/virtualenvwrapper.sh
fi

## projects folder
export WORKSPACE_HOME="$HOME/projects"
export PATH="$HOME/.local/bin:$PATH"

## nimble
eval "$(nimble init -)"

## AWS cli
if [[ -n "$(which aws_completer)" ]]; then
    complete -C "$(which aws_completer)" aws
    export PATH="/usr/local/aws/bin:$PATH"
fi

## Keychain
eval $(keychain --eval --quiet)

## Google cloud
if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]; then
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
fi
if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc ]; then
    . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
fi

## Dedup path
export PATH=`python2.7 -c 'import os; from collections import OrderedDict; print(":".join(OrderedDict.fromkeys(filter(len, os.environ["PATH"].split(":"))).keys()))'`

## Pass
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PASSWORD_STORE_EXTENSIONS_DIR=$HOME/.local/lib/password-store/extensions
export PASSWORD_STORE_GENERATED_LENGTH=15

## Opt-out from brew analytics
export HOMEBREW_NO_ANALYTICS=1

## Direnv
eval $(direnv hook bash)
