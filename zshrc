# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="juanghurtado"
ZSH_THEME="gnzh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
plugins=(git cp docker vagrant command-not-found fish-init debian pip ssh-agent autojump)

source $ZSH/oh-my-zsh.sh
# conflict with silversearcher-ag
unalias ag
[[ -n "${key[Up]}"      ]] && bindkey  "${key[Up]}"      history-search-backward
[[ -n "${key[Down]}"    ]] && bindkey  "${key[Down]}"    history-search-forward
if type fish-init > /dev/null; then
    alias finit=fish-init
fi

# User configuration

#export PATH=$HOME/bin:/usr/local/bin:/usr/local/go/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
# http proxy
#dpkg-query -W squid3 2>&1 1>/dev/null && export http_proxy=http://127.0.0.1:3128
# DISPLAY
remote_ip=`env | awk '$0 ~ /^SSH_CLIENT=/ {print substr($1, index($1, "=") + 1)}'`
if [ ! -z "$remote_ip" ] ; then
    export DISPLAY=$remote_ip:0
    echo DISPLAY=$DISPLAY
fi
# pythonbrew
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"
# git completion
#[ -f ~/.git-bash-completion.sh ] && . ~/.git-bash-completion.sh
#complete -W "$(echo $(grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //'))" ssh
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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

## pyenv
#[[ -r "/usr/local/bin/virtualenvwrapper_lazy.sh" ]] && source "/usr/local/bin/virtualenvwrapper_lazy.sh"
#[ -n "$VIRTUAL_ENV" ] && source "$VIRTUAL_ENV/bin/activate"
#if type pyenv 2>&1 >/dev/null; then
#    eval "$(pyenv init -)"
#    export PATH="$HOME/.pyenv/bin:$PATH"
#fi


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
#source ~/.fzf.zsh

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
    python -mjson.tool
}

function xml() {
    xmllint --format -
}


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

# Go environment
export GOROOT=$HOME/go
# export GOBIN=$GOROOT/bin
# export GOARCH=386
# export GOOS=linux
export PATH=$GOROOT/bin:$PATH
export GOPATH=$HOME/workspace/Go
