# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  docker
  docker-compose
  deno
)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias tmux="tmux -f ~/.config/tmux/.tmux.conf"

if command -v exa > /dev/null 2>&1; then
	alias l="exa --icons"
	alias ls="exa --icons"
	alias ll="exa -l"
	alias lll="exa -la"
	alias lt="exa --icons --tree --git-ignore"
else
	alias l="ls"
	alias ll="ls -l"
	alias lll="ls -la"
fi

# Custom defined private aliases in a specific setup
if [ -f /home/$USER/.dotfiles/custom-aliases.zsh ]; then
	source /home/$USER/custom-aliases.zsh
fi

# Deno
export DENO_INSTALL="/home/$USER/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# AWS
export PATH=~/.local/bin:$PATH

# fnm
export PATH="/home/$USER/.fnm:$PATH"
eval "`fnm env`"
