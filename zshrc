# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ------------------- ZSH PLUGINS 
autoload -U +X compinit && compinit
source <(kubectl completion zsh)
source $HOME/enhancd/init.sh
MYVIMRC=$HOME/.vimrc

# ZSH THEME
ZSH_THEME="powerlevel10k/powerlevel10k"

# BELL SPECIFICS -- ALIAS
alias dce="docker compose"
alias dcex="docker compose exec -it"
alias dcud="docker compose up -d"
alias dcb="docker compose build"
alias cls=clear
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
alias goland='/usr/local/bin/goland'
alias charm='/usr/local/bin/charm'
alias idea='/usr/local/bin/idea'
alias timenow='date +"%Y-%m-%dT%H:%M:%S%z"'
alias gpo='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gp='git push'
alias gpl='git pull'
alias py='python3'
alias k='kubectl'
alias ocev='oc get events --sort-by='\''.metadata.creationTimestamp'\''' 
alias firefox='open -a Firefox'
alias clr_pycache='find . | grep -E "(/__pycache__$|\.pyc$|\.pyo$)" | xargs rm -rf'
alias go_fmt_all='gofmt -s -w .'


# GOTO SHORTHANDS
export MARKPATH=$HOME/.goto-dirs

# Populate the hash for dir bookmarks
for link ($MARKPATH/*(N@)) {
	hash -d -- ${link:t}=${link:A}
}

function goto {
    if [ -z "$1" ]; then
        #no arguments given
        hash -d
    else
		    ~$1
	fi
}

function save {
    if [ -z "$1" ]; then
        #no arguments given
        echo "ERROR: Missing argument\n"
        echo "usage:"
        echo "save <name_of_bookmark>"
    else
        if [ -h "$MARKPATH/$1" ]; then
            #if soft link exists, delete before creating new soft link with the same name
            rm -rf $MARKPATH/$1
        fi
        ln -s $PWD $MARKPATH/$1
        hash -d -- $1=$PWD
	fi
}

function unsave {
    if [ -z "$1" ]; then
        #no arguments given
        echo "ERROR: Missing argument\n"
        echo "usage:"
        echo "unsave <name_of_bookmark>"
    else
        #if bookmark exists in hash table, then remove
        if [ -h "$MARKPATH/$1" ]; then
            rm -If ~/.goto-dirs/$1
            unhash -d $1
        fi
    fi
}

#zsh completion for go commands
function goto_completion {
    #for each link in MARKPATH
    for link ($MARKPATH/*(N@)) {
            #add to completion
	          compadd ${link:t}
    }
}

#go auto completion
compdef goto_completion goto

# PLUG INS
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
 
