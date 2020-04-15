## LANG
if [ -z "$LC_ALL" ]; then
    export LC_ALL=en_US.UTF-8
fi
if [ -z "$LANG" ]; then
    export LANG=en_US.UTF-8
fi

## Prompt
PROMPT_DIRTRIM=2
if [ -f ~/.bash_theme ]; then
    # shellcheck source=/dev/null
    . ~/.bash_theme
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
    ssh-keygen*:exterminate_ds_store:lskites:suspend:autobrew"

# Bind arrow to search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

## Lesspipe
LESSOPEN="|$(command -v lesspipe.sh) %s"
export LESSOPEN
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
    . ~/.bash_functions
fi

## Completions
if [ -e "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    # Load Brew installed bash-completion
    BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
    export BASH_COMPLETION_COMPAT_DIR
    # shellcheck source=/dev/null
    . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [ -e /etc/bash_completion ]; then
    # shellcheck source=/dev/null
    . /etc/bash_completion
fi

if [[ "$OSTYPE" == darwin* ]]; then
    # Brew installed jira
    if [ -n "$(command -v jira)" ]; then
        eval "$(jira --completion-script-bash)"
    fi
    # Brew installed google cloud tools
    if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]; then
        . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
    fi
    if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc ]; then
        . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
    fi
fi

# Locally installed
if [ -d ~/.local/share/bash-completion ]; then
    for _FILE in ~/.local/share/bash-completion/*; do
        # shellcheck source=/dev/null
        . "$_FILE"
    done
fi

## Alias
if [ -f ~/.bash_alias ]; then
    # shellcheck source=/dev/null
    . ~/.bash_alias
fi

## PATH
# Brew paths
if [[ "$OSTYPE" == darwin* ]]; then
    # SQLite
    PATH="/usr/local/opt/sqlite/bin:$PATH"
    # Python3
    PATH="/usr/local/opt/python/libexec/bin:$PATH"
    # Logrotate is installed in sbin
    PATH="/usr/local/sbin:$PATH"
    # Sphinx Docs
    PATH="/usr/local/opt/sphinx-doc/bin:$PATH"
fi
# Projects folder
export WORKSPACE_HOME="$HOME/projects"
PATH="$HOME/.local/bin:$PATH"

## Applications setup
# virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON="$(command -v python2)"
export VIRTUALENVWRAPPER_PYTHON
export WORKON_HOME=~/.virtualenvs
if [ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]; then
    # shellcheck source=/dev/null
    . /usr/local/bin/virtualenvwrapper_lazy.sh
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
export PASSWORD_STORE_GENERATED_LENGTH=20
export PASSWORD_STORE_EXTENSIONS_DIR="/usr/local/lib/password-store/extensions"
export PASSWORD_STORE_OUTDATED_MAX_AGE=90
# Brew
export HOMEBREW_NO_ANALYTICS=1
# Direnv
if [ -n "$(command -v direnv)" ]; then
    eval "$(direnv hook bash)"
fi
# Fuck
if [ -n "$(command -v thefuck)" ]; then
    eval "$(thefuck --alias)"
fi
# Terraform completion
if [ -f "/usr/local/bin/terraform" ]; then
    complete -C /usr/local/bin/terraform terraform
fi
# nvm
export NVM_DIR="$HOME/.nvm"
if [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
    # Load nvm
    . "/usr/local/opt/nvm/nvm.sh"
fi
if [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ]; then
    # This loads nvm bash_completion
    . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
fi

# ## Dedup path
PATH="$(python2.7 -c 'import os; from collections import OrderedDict; print(":".join(OrderedDict.fromkeys(filter(len, os.environ["PATH"].split(":"))).keys()))')"
export PATH

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
if [ -f "/Users/czr/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash" ]; then
    # shellcheck source=/dev/null
    . "/Users/czr/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash"
fi
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
if [ -f "/Users/czr/.config/yarn/global/node_modules/tabtab/.completions/sls.bash" ]; then
    # shellcheck source=/dev/null
    . "/Users/czr/.config/yarn/global/node_modules/tabtab/.completions/sls.bash"
fi
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
if [ -f "/Users/czr/.config/yarn/global/node_modules/tabtab/.completions/slss.bash" ]; then
    # shellcheck source=/dev/null
    . "/Users/czr/.config/yarn/global/node_modules/tabtab/.completions/slss.bash"
fi
