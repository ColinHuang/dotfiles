ZSH=$HOME/.oh-my-zsh
ZSH_THEME="spaceship"

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true" 
# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git cp docker docker-compose vagrant command-not-found debian pip ssh-agent pyenv virtualenv kubectl)

source $ZSH/oh-my-zsh.sh
# conflict with silversearcher-ag
unalias ag
[[ -n "${key[Up]}"      ]] && bindkey  "${key[Up]}"      history-search-backward
[[ -n "${key[Down]}"    ]] && bindkey  "${key[Down]}"    history-search-forward

# User configuration
# DISPLAY
remote_ip=`env | awk '$0 ~ /^SSH_CLIENT=/ {print substr($1, index($1, "=") + 1)}'`
if [ ! -z "$remote_ip" ] ; then
    export DISPLAY=$remote_ip:0
    echo DISPLAY=$DISPLAY
fi

# ssh loop
function sshl() 
{
    timeout=10
    while [ 1 ] ; do 
        ssh "$@"
        read "Press any key to re-connect... or wait $timeout seconds to restart" -t $timeout foobar
    done
}

function git-export-diff() {
    if [ $# -ne 1 ] ; then
        echo "git-export-diff <version number>"
        return
    fi
    for i in `git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT $1`
    do 
        mkdir -p `dirname "$1/$i"`
        echo "$1/$i"
        git show $1:$i > $1/$i
    done
}

function man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

# history
export HISTCONTROL=erasedups
export HISTTIMEFORMAT='%F %T '

function tl() 
{
    tree -C $* | less -R
}

function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

function ppgrep() {
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

function ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
}

#bindkey "^J" backward-char
#bindkey "^H" backward-word #Notice!
#bindkey "^K" forward-char
#bindkey "^L" forward-word
if [ -n "$VIRTUAL_ENV" ]; then
    if [ -z "$OLD_RPS1" ]; then
        OLD_RPS1=$RPS1
    fi
    RPS1="$(basename ${VIRTUAL_ENV} 2>/dev/null) $OLD_RPS1"
    export PATH="$VIRTUAL_ENV/bin:$PATH"
fi

if netstat -ntul | grep -q :3128; then
    export HTTP_PROXY=http://127.0.0.1:3128
    export http_proxy=$HTTP_PROXY
fi

function json() {
    jq .
}

function xml() {
    xmllint --format -
}

mykill () {
    ps h -o pid,command | grep "$@" | grep -v grep | sed 's/^ \+//' | cut -d ' ' -f 1 
}

# Instantly jump to your ag matches. https://github.com/aykamko/tag
if (( $+commands[tag] )); then
    export TAG_SEARCH_PROG=ag  # replace with rg for ripgrep
    tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
    alias ag="tag --ignore-dir vendor"  # replace with rg for ripgrep
fi

export QIP=127.0.0.1
export QPORT=9000

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"


# workaround for Home/End key from Xshell or Putty
bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line

# Go environment
# export GOROOT=$HOME/go
export GOROOT=/usr/local/go
export GOPATH=$HOME/workspace
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv
if [[ -d $HOME/.pyenv ]]
then
    export PATH=$HOME/.pyenv/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# FZF command line
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--no-mouse --reverse --exact --border"

