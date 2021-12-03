#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source base16 256 colourspace script.
if [[ -s "$HOME/.config/base16-shell/scripts/base16-material.sh" ]]; then
  source "$HOME/.config/base16-shell/scripts/base16-material.sh"
fi

# Aliases
alias g="git"
alias gclean="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"
alias m="tmuxinator"
alias t="tmux"
alias a="tmux attach -t"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/plugins/java/set-java-home.zsh

fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit
compinit

eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export PATH="/opt/homebrew/local/sbin:$PATH"
export NODEJS_CHECK_SIGNATURES="no"

eval "$(direnv hook zsh)"
