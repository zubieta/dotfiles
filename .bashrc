# Set default locale
export LC_ALL=${LC_ALL:-en_US.UTF-8}
export LANG=${LANG:-en_US.UTF-8}

# Prompt max path length
export PROMPT_DIRTRIM=2

# Define ls/tree coloring
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LSCOLORS="exfxcxdxbxegedabagacad"
# Tell ls to be colourful
export CLICOLOR=1
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# History
export HISTCONTROL="ignorespace:erasedups:ignoredups"
export HISTSIZE=10000
export HISTIGNORE="keybase *:ass *:wifipass *"

# Bind arrow to search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Lesspipe
LESSOPEN="|$(command -v lesspipe.sh) %s"
export LESSOPEN
export LESS_ADVANCED_PREPROCESSOR=1

## Default programs
[ "$(command -v nvim)" ] && EDITOR=nvim || EDITOR=vim
export EDITOR
export VISUAL="$EDITOR"

[[ "$OSTYPE" == darwin* ]] && BROWSER='open -a Firefox' || BROWSER=firefox
export BROWSER

export PAGER=less

# Source other configuration files in lexicographical order
if [ -d ~/.bash ]; then
    for FILE in ~/.bash/*; do
        # shellcheck source=/dev/null
        source "$FILE"
    done
fi

# Dedup path
_RC_DEDUP_SCRIPT="
import os
from collections import OrderedDict
path = (p.strip() for p in os.getenv('PATH', '').split(':') if p.strip())
print(':'.join(OrderedDict.fromkeys(path).keys()))
"
PATH="$(python -c "$_RC_DEDUP_SCRIPT")"
export PATH
unset _RC_DEDUP_SCRIPT
