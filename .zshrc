export TERM=xterm-256color

# Disable terminal startup message
ZSH_DISABLE_COMPFIX=true

# path to your oh-my-zsh installation.
export ZSH="/Users/dmytroparfeniuk/.oh-my-zsh"

# path to your bin/sbin
export PATH=$PATH:/usr/local/sbin:/usr/local/bin

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

# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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

# [homebrew]
eval "$(/opt/homebrew/bin/brew shellenv)"


# =============================================================
# [user configuration]
# =============================================================
DEV_FOLDER="$HOME/dev"

# navigation
alias tmp="cd /tmp"
alias downloads="cd ~/Downloads"
alias desktop="cd ~/Desktop"
alias zshrc="nv ~/.zshrc"
alias icloud="/Users/dmytroparfeniuk/Library/Mobile\ Documents/com~apple~CloudDocs"
alias notes="/Users/dmytroparfeniuk/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Dmytro && nvim"


alias ssh_config="nv ~/.ssh/config"
alias nvim_config="nv ~/.config/nvim"

alias dev="cd $DEV_FOLDER"
alias tools="cd $DEV_FOLDER/tools"
alias mine="cd $DEV_FOLDER/parfeniukink"
alias poc="cd $DEV_FOLDER/parfeniukink/poc"
alias proj="cd $DEV_FOLDER/projects"
alias archive="cd $DEV_FOLDER/archived"
alias dotfiles="cd $DEV_FOLDER/parfeniukink/dotfiles && nvim"

# [system commands]
alias e="exit"
alias quit="exit"
alias q="exit"
alias copy="pbcopy" # cat file.txt | copy
alias du="du -h -s"
alias utc='export TS="UTC"'
alias ls="ls -lFh"
alias ee="set -o allexport; source .env; set +o allexport" # export from .env

alias dns-restart="sudo killall -HUP mDNSResponder" # restart dsn

# [git]
alias pc="pre-commit"
alias wip="git add . && git commit -m '🚧 WIP' -n && git push"

# [grep]
alias grep="grep --color=auto"
alias grep_empty="grep '^$'"

# [bat]
alias cat="bat"

# [tmux]
alias tl="tmux ls"
alias ta="tmux attach -t"
alias ts="tmux new -s"
alias tk="tmux kill-session -t"

# [tmuxinator]
alias tm="tmuxinator"

# [neovim]
export PATH=$PATH:$DEV_FOLDER/tools/neovim/bin
alias nv="nvim"

# [gtime]
# Usage: time [-v] python script.py
alias time="gtime -v"

# [tldr]
TLDR_AUTO_UPDATE_DISABLED=1

# [eza]
alias l="eza -l --icons --time-style iso --header --no-user --sort type"
alias la="eza -l --icons --time-style iso --header --no-user --sort type -a"
alias llg="eza -l --icons --time-style iso --header --no-user --sort type -a --git-ignore"
alias t="tree -C -a"

# [llama.cpp]
export PATH="$HOME/llama.cpp/build/bin:$PATH"

# [docker]
# use buildx
export DOCKER_BUILDKIT=1

alias d="docker"
alias di="docker images | sort"
alias da="docker attach"
alias dc="docker compose"
alias db="docker compose build"
alias dcup="docker compose up -d --no-recreate"
alias dcps="docker compose ps"
alias dcd="docker compose down"
alias dcr="docker compose restart"
alias dce="docker compose exec"
alias dcl="docker compose logs"
alias dclt="docker compose logs --tail 10"

# [kubernetes]
alias ku="kubectl"

# [postgresql]
export PATH=/opt/homebrew/opt/postgresql@16/bin:$PATH
# export PATH=$PATH:$DEV_FOLDER/tools/postgresql/bin



# [golang]
# export GOROOT=/opt/homebrew/opt/go
# export GOPATH=~/go
# export GOPROXY="https://proxy.golang.org"
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin



# [rust]
export PATH=$PATH:/Users/dmytroparfeniuk/.rustup/toolchains/stable-x86_64-apple-darwin/bin
RUST_BACKTRACE=full



# [python]
alias python="python3"
export PYTHONBREAKPOINT=ipdb.set_trace
export PYTHONDEVMODE=1
export PYTHONASYNCIODEBUG=1
# export PYTHONMALLOC=malloc

alias ctags_update="ctags -R --fields=+l --languages=python --python-kinds=-iv -f tags"

alias activate="source venv/bin/activate"
alias venv3.8="virtualenv --python python3.8 venv && source venv/bin/activate && pip install pip-tools"
alias venv3.9="virtualenv --python python3.9 venv && source venv/bin/activate && pip install pip-tools"
alias venv3.10="virtualenv --python python3.10 venv && source venv/bin/activate && pip install pip-tools"
alias venv3.11="virtualenv --python python3.11 venv && source venv/bin/activate && pip install pip-tools"
alias venv3.12="virtualenv --python python3.12 venv && source venv/bin/activate && pip install pip-tools"
alias venv3.13="virtualenv --python python3.13 venv && source venv/bin/activate && pip install pip-tools"

# poetry
alias poetry_venvs="cd $HOME/Library/Caches/pypoetry/virtualenvs/"
export PATH="$HOME/.local/bin:$PATH"



# [dart]
# path to pub packages
PATH="$PATH":"$HOME/.pub-cache/bin"
# path to flutter binaries
export PATH="$HOME/flutter/bin:$PATH"
# CocaPods
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH


# [kafka]
export PATH=/opt/homebrew/opt/kafka/bin:$PATH


# [k8s]
export KUBECONFIG=$HOME/.k3s.yaml
alias k="kubectl"
alias kg="kubectl get"
alias ka="kubectl apply -f"
alias kd="kubectl delete"
alias kl="kubectl get all -o wide"
alias kn="kubectl config set-context --namespace="


# ==================================
# export API keys
# ==================================
source ~/.env
