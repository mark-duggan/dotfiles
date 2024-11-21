zmodload zsh/datetime
setopt PROMPT_SUBST
PS4='+$EPOCHREALTIME %N:%i> '

logfile=$(mktemp /tmp/zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
exec 3>&2 2>$logfile

setopt XTRACE
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use antigen
source $HOME/.antigen.zsh

# Use Oh-My-Zsh
antigen use oh-my-zsh

# Set theme
antigen theme romkatv/powerlevel10k
# antigen theme agnoster

# Set plugins (plugins not part of Oh-My-Zsh can be installed using githubusername/repo)
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle "MichaelAquilina/zsh-autoswitch-virtualenv"
antigen bundle aws/aws-cli
antigen bundle pip
antigen bundle command-not-found
antigen bundle docker
antigen bundle kubectl
antigen bundle git-extras
antigen bundle direnv
antigen bundle git-auto-fetch


if [[ "$OSTYPE" == "darwin"* ]]; then
    antigen bundle osx
fi

# Apply changes
antigen apply

# AWS Autocomplete
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# Kubernetes Autocomplete
if curl -kv --connect-timeout 0.06 $(yq '.clusters[].cluster.server' ~/.kube/config) > /dev/null 2>&1; then
    source <(kubectl completion zsh)
fi

# Update PATH
PATH=$PATH:~/.local/bin

# AWS Pager

export AWS_PAGER=""

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
unsetopt XTRACE
exec 2>&3 3>&-
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}
[ -f ~/.aws_profiles.sh ] && source ~/.aws_profiles.sh && chpwd_functions+=(aws_profiles)
[ -f ~/.aws_regions.sh ] && source ~/.aws_regions.sh && chpwd_functions+=(aws_regions)
[ -f ~/.aws_functions.sh ] && source ~/.aws_functions.sh && chpwd_functions+=(aws_functions)
