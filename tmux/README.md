# Setup

```bash
# MacOS Intel
brew install tmux

# Apple Silicon
arch -arm64 brew install tmux

# Ubuntu
apt install tmux
```

## Install plugin manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In TMUX session to install plugins using tmp
<prefix>, then Shift + i
```

## The minimal TMUX configuration file

Copy the file into this folder

```bash
~/.tmux.conf
```

To setup plugins

```bash
tmux
<prefix> Shift + i
```

# 🏃‍♂️ Usage

```bash
# attach to the existed session
tmux attach -t

# kill the session
tmux kill-session -t

# sessions list
tmux ls

# create a new session
tmux new -s
```
