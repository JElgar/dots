# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Config constants 
export ME_USER="jelgar"
export ME_HOME="/home/$USER"
export OS="linux"

if [ -f ~/.zshrc-local ]; then
    source ~/.zshrc-local
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Startup Commands
if [ "$TMUX" = "" ]; then tmux new -As0; fi

export FLUTTER_ROOT="$HOME/Documents/dev/flutter/bin"
export CHROME_EXECUTABLE="/bin/google-chrome-stable"
export ANDROID_HOME="$HOME/Android/Sdk"

path+=("$HOME/Documents/dev/flutter/bin")
path+=("$HOME/Documents/dev/flutter/.pub-cache/bin")
path+=("$HOME/Documents/dev/android-studio/bin")
path+=("$HOME/.npm-packages/bin")
path+=("$HOME/.node_modules/bin")
path+=("/Documents/dev/node/bin")
path+=("/usr/lib/dart/bin")
path+=("$HOME/bin")
path+=("$HOME/.emacs.d/bin")
path+=("$HOME/Documents/dev/scripts")
path+=("$HOME/.config/scripts")
path+=("$HOME/.local/share/gem/ruby/3.0.0/bin")
path+=("/usr/local/go/bin")
path+=("$HOME/.pub-cache/bin")

# path+=('/home/james/Development/elm/bin')
export PATH

export LD_LIBRARY_PATH=/usr/local/include:$LD_LIBRARY_PATH

export npm_config_prefix=~/.node_modules

# Set defualt editor to nvim
export VISUAL=nvim
export EDITOR="$VISUAL"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
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
# DISABLE_MAGIC_FUNCTIONS=true

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  docker-compose
  flutter
  yarn
  npm
  kubectl
  microk8s
  golang
  helm
  # zsh-syntax-highlighting
  # zsh-autosuggestions
  z
  dotenv
)

source $ZSH/oh-my-zsh.sh

# export "GOROOT=/usr/local/go"

export "GOPATH=$HOME/Documents/dev/go"
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    Codi $syntax" "$@"
}

alias gtw="google-chrome-stable \`sed -n 1p .links\`"
alias gtb="google-chrome-stable \`sed -n 2p .links\`"
alias gtv="google-chrome-stable \`sed -n 3p .links\`"
alias v="nvim"
alias ovim="vim.basic"
#alias bris-sync="rclone sync ~/CS bris:"
alias bris-snowy="ssh snowy"
alias bris-windows="rdesktop -u UOB\za18968 -g 1920x1020 studentremotedesktop.bris.ac.uk"
alias cs="cd ~/CS/"
alias logisim="java -jar ~/CS/ComputerArchitecture/Logisim/logisim-generic-2.7.1.jar"
alias y2="cd ~/Documents/uni/Year2/"
alias c="xclip"
alias e="emacs -nw"
alias ls="exa"
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias bl='xbacklight -set'
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

## Git
alias gs='git status'
alias gc='git commit'
alias gch='git checkout'
alias ga='git add'
alias gp='git push'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# pnpm
export PNPM_HOME="/home/jelgar/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [ -e /home/jelgar/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jelgar/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
autoload -Uz compinit && compinit -i
