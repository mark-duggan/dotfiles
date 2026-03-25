# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Pinned third-party revisions (bump when you want newer upstream code).
DOTFILES_OMZ_SHA=9151236d1e0cb64b2e803d7ec1736c7a717efc33
DOTFILES_MISE_VERSION=v2026.3.15
DOTFILES_P10K_TAG=v1.20.0
DOTFILES_ZSH_AUTOSUGGESTIONS_TAG=v0.7.1
DOTFILES_ZSH_SYNTAX_HIGHLIGHTING_TAG=0.8.0
DOTFILES_ZSH_COMPLETIONS_TAG=0.36.0

_ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# install oh-my-zsh, plugins and themes if not present
if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
	echo "oh-my-zsh not installed. Installing pinned revision..."
	if [ ! -d "$HOME/.oh-my-zsh/.git" ]; then
		mkdir -p "$HOME/.oh-my-zsh"
		git init -q "$HOME/.oh-my-zsh"
		git -C "$HOME/.oh-my-zsh" remote add origin https://github.com/ohmyzsh/ohmyzsh.git
	fi
	git -C "$HOME/.oh-my-zsh" fetch --depth 1 origin "$DOTFILES_OMZ_SHA"
	git -C "$HOME/.oh-my-zsh" checkout -q FETCH_HEAD
fi

if [ ! -d "$HOME/.ssh" ]; then
	mkdir -p "$HOME/.ssh"
	chmod 700 "$HOME/.ssh"
fi

if [ ! -d "$_ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
	echo "zsh-autosuggestions is not installed. Installing..."
	git clone --depth 1 --branch "$DOTFILES_ZSH_AUTOSUGGESTIONS_TAG" \
		https://github.com/zsh-users/zsh-autosuggestions.git \
		"$_ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$_ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
	echo "zsh-syntax-highlighting is not installed. Installing..."
	git clone --depth 1 --branch "$DOTFILES_ZSH_SYNTAX_HIGHLIGHTING_TAG" \
		https://github.com/zsh-users/zsh-syntax-highlighting.git \
		"$_ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$_ZSH_CUSTOM/plugins/zsh-completions" ]; then
	echo "zsh-completions is not installed. Installing..."
	git clone --depth 1 --branch "$DOTFILES_ZSH_COMPLETIONS_TAG" \
		https://github.com/zsh-users/zsh-completions.git \
		"$_ZSH_CUSTOM/plugins/zsh-completions"
fi

if [ ! -f "$HOME/.local/bin/mise" ]; then
	echo "mise is not installed. Installing..."
	curl -fsSL https://mise.run | MISE_VERSION="$DOTFILES_MISE_VERSION" sh
fi

"$HOME/.local/bin/mise" use --global atuin > /dev/null 2>&1

if [ ! -d "$_ZSH_CUSTOM/themes/powerlevel10k" ]; then
	echo "powerlevel10k is not installed. Installing..."
	git clone --depth 1 --branch "$DOTFILES_P10K_TAG" \
		https://github.com/romkatv/powerlevel10k.git \
		"$_ZSH_CUSTOM/themes/powerlevel10k"
fi
unset _ZSH_CUSTOM
unset DOTFILES_OMZ_SHA DOTFILES_MISE_VERSION DOTFILES_P10K_TAG \
	DOTFILES_ZSH_AUTOSUGGESTIONS_TAG DOTFILES_ZSH_SYNTAX_HIGHLIGHTING_TAG \
	DOTFILES_ZSH_COMPLETIONS_TAG

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
    git-extras
    git-auto-fetch
    python
    pip
    command-not-found
    aws
    docker
    mise
    ssh-agent
    zsh-autosuggestions
    zsh-syntax-highlighting
)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration

# ssh-agent settings
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export PATH="$PATH:$HOME/.local/bin"
export AWS_PAGER=""
eval "$(mise activate zsh)"
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

[ -f ~/.aws_functions.sh ] && source ~/.aws_functions.sh && chpwd_functions+=(aws_functions)

eval "$(atuin init zsh)"

# pnpm
export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
