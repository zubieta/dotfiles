## LANG
if [ -n "$LC_ALL" ]; then
    export LC_ALL=en_US.UTF-8
fi
if [ -n "$LANG" ]; then
    export LANG=en_US.UTF-8
fi

## Prompt
PROMPT_DIRTRIM=2
if [ -f ~/.bash_theme ]; then
    # shellcheck source=/dev/null
    source ~/.bash_theme
fi

## Colors
# Define ls/tree coloring
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LSCOLORS="exfxcxdxbxegedabagacad"
# Tell ls to be colourful
export CLICOLOR=1
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

## History
export HISTCONTROL="ignorespace:erasedups:ignoredups"
export HISTSIZE=10000
export HISTIGNORE="?:??:???:history:cd ~:cd -:cd ..:tree:clear:echo:exit:\
    git ??:git ???:git ????:git ?????:git status:git unstash:\
    lyrics:mpsyt:music:ncmcpp:weechat:mutt:turses:bugwarrior-pull:t *:task *:\
    mktemp:mount:alias:keybase:pass *:wifipass *:wormhole:* wormhole:wormhole *:\
    clip2worm:worm2clip:ipython:calc *:* --help:* -h:* help:help *:apropos *:man *:\
    tldr *:what *:whatis *:which *:*tmux new-session -A -s DEV *:python:python3:\
    python2:python2.7:make:deactivate:lsvirtualenv:workon *:date:reset:glances:\
    htop:ifconfig:mount:myip:netstat:nettop:sysinfo:systop:vnstat:nimble:nimble ??:\
    ssh-keygen*:exterminate_ds_store:lskites:suspend"

# Bind arrow to search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

## Lesspipe
# shellcheck disable=SC2016
export LESSOPEN='|$(which lesspipe.sh) %s'
export LESS_ADVANCED_PREPROCESSOR=1

## Default programs
export EDITOR='nvim'
if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open -a Firefox'
elif [ -n "$(command -v firefox)" ]; then
    export BROWSER=firefox
fi

## Functions
if [ -f ~/.bash_functions ]; then
    # shellcheck source=/dev/null
    source ~/.bash_functions
fi

## Completions
if [[ "$OSTYPE" == darwin* ]]; then
    # Load Brew installed bash-completion
    if [ -f /usr/local/share/bash-completion/bash_completion ]; then
        source /usr/local/share/bash-completion/bash_completion
    fi
    # Load Brew installed completers
    if [ -d /usr/local/etc/bash_completion.d ]; then
        for _FILE in /usr/local/etc/bash_completion.d/*; do
            # shellcheck source=/dev/null
            source "$_FILE"
        done
    fi
    # Brew installed jira
    if [ -n "$(command -v jira)" ]; then
        eval "$(jira --completion-script-bash)"
    fi
    # Brew installed google cloud tools
    if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]; then
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
    fi
    if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc ]; then
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
    fi
fi
# Locally installed
if [ -d ~/.local/share/bash-completion ]; then
    for _FILE in ~/.local/share/bash-completion/*; do
        # shellcheck source=/dev/null
        source "$_FILE"
    done
fi

## Alias
if [ -f ~/.bash_alias ]; then
    # shellcheck source=/dev/null
    source ~/.bash_alias
fi

## PATH
# Brew paths
if [[ "$OSTYPE" == darwin* ]]; then
    # SQLite
    PATH="/usr/local/opt/sqlite/bin:$PATH"
fi
# Projects folder
export WORKSPACE_HOME="$HOME/projects"
PATH="$HOME/.local/bin:$PATH"

## Applications setup
# virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON="$(command -v python2)"
export VIRTUALENVWRAPPER_PYTHON
export WORKON_HOME=~/.virtualenvs
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    # shellcheck source=/dev/null
    source /usr/local/bin/virtualenvwrapper.sh
fi
# Nimble
if [ -n "$(command -v nimble)" ]; then
    eval "$(nimble init -)"
fi
# Keychain
if [ -n "$(command -v keychain)" ]; then
    eval "$(keychain --eval --quiet)"
fi
# Pass
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PASSWORD_STORE_EXTENSIONS_DIR="$HOME/.local/lib/password-store/extensions"
export PASSWORD_STORE_GENERATED_LENGTH=15
# Brew
export HOMEBREW_NO_ANALYTICS=1
## Direnv
if [ -n "$(command -v direnv)" ]; then
    eval "$(direnv hook bash)"
fi

# ## Dedup path
PATH="$(python2.7 -c 'import os; from collections import OrderedDict; print(":".join(OrderedDict.fromkeys(filter(len, os.environ["PATH"].split(":"))).keys()))')"
export PATH
