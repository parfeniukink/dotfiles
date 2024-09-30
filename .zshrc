# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export TERM=xterm-256color

# Disable terminal startup message
ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="/Users/dmytroparfeniuk/.oh-my-zsh"
export PATH=$PATH:/usr/local/sbin

# Langs preferences
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="simple"

export EDITOR=nvim
export VISUAL="$EDITOR"

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    nmap
    aws
	dotenv
)

source $ZSH/oh-my-zsh.sh

# [Homebrew]
eval "$(/opt/homebrew/bin/brew shellenv)"


# =============================================================
# User configuration
# =============================================================

export PATH=$PATH:/usr/local/sbin:/usr/local/bin
export PATH=$PATH:/usr/local/opt/openssl@1.1/bin
export PATH=$PATH:/usr/local/opt/curl/bin


# ==================================
# Aliases
# ==================================
# [Base]
alias downloads="cd ~/Downloads"
alias desktop="cd ~/Desktop"
alias zshrc="nv ~/.zshrc"
alias icloud="/Users/dmytroparfeniuk/Library/Mobile\ Documents/com~apple~CloudDocs"

alias e="exit"
alias cls="clear"
alias copy="pbcopy" # cat file.txt | copy
alias du="du -h -s"

# [.ENV files]
alias ee="set -o allexport; source .env; set +o allexport" # Export from .env

# [Projects folder]
PROJECTS="$HOME/Projects"
alias proj="cd $PROJECTS"

# [SSH]
alias ssh_config="nv ~/.ssh/config"

# [Docker]
alias d="docker"
alias di="docker images | sort"
alias da="docker attach"
alias dc="docker-compose"
alias db="docker-compose build"
alias dcup="docker-compose up -d --no-recreate"
alias dcps="docker-compose ps"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dce="docker-compose exec"
alias dcl="docker-compose logs"
alias dclt="docker-compose logs --tail 10"
alias dcerase="docker-compose rm -v -f"

# [Files]
alias ls="ls -lFh"
alias l="eza -l --icons --time-style iso --header --no-user --sort type"
alias la="eza -l --icons --time-style iso --header --no-user --sort type -a"
alias llg="eza -l --icons --time-style iso --header --no-user --sort type -a --git-ignore"
alias t="tree -L"

# [TMUX]
alias tl="tmux ls"
alias ta="tmux attach -t"
alias ts="tmux new -s"
alias tk="tmux kill-session -t"

# [VIM]
alias nv="nvim"
alias nvim_config="cd ~/.config/nvim/ && nvim ./"

# [Gtime]
# Usage: time [-v] python script.py
alias time="gtime -v"

# [GIT]
alias pc="pre-commit"

# ==================================
# Databases
# ==================================
export PATH=/opt/homebrew/opt/postgresql@13/bin:$PATH
export PATH=/opt/homebrew/opt/postgresql@14/bin:$PATH



# ==================================
# Golang
# ==================================
# export GOROOT=/opt/homebrew/opt/go
# export GOPATH=~/go
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin



# ==================================
# Rust
# ==================================
export PATH=$PATH:/Users/dmytroparfeniuk/.rustup/toolchains/stable-x86_64-apple-darwin/bin
RUST_BACKTRACE=full



# ==================================
# Python
# ==================================
export PYTHONBREAKPOINT=pudb.set_trace
# export PYTHONDEVMODE=0
# export PYTHONMALLOC=malloc

# [Ctags]
alias ctags_update="ctags -R --fields=+l --languages=python --python-kinds=-iv -f tags"

alias python="python3"
alias pip="pip3"
alias activate="source venv/bin/activate"
alias venv3.9="virtualenv --python python3.9 venv && source venv/bin/activate && pip install pip-tools"
alias venv3.10="virtualenv --python python3.10 venv && source venv/bin/activate && pip install pip-tools"
alias venv3.11="virtualenv --python python3.11 venv && source venv/bin/activate && pip install pip-tools"
alias venv3.12="virtualenv --python python3.12 venv && source venv/bin/activate && pip install pip-tools"

# [Poetry]
export PATH="$HOME/.local/bin:$PATH"
alias poetry_venvs="cd $HOME/Library/Caches/pypoetry/virtualenvs/"



# ==================================
# Dart
# ==================================

# [Flutter]
# export PATH="$HOME/flutter/bin:$PATH"

# [CocaPods]
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH



# ==================================
# Kafka
# ==================================
export PATH=/opt/homebrew/opt/kafka/bin:$PATH




# ==================================
# API Keys
# ==================================



# ==================================
# TMP aliases
# ==================================
