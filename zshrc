#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

eval "$(rbenv init -)"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source base16 256 colourspace script.
if [[ -s "$HOME/.config/base16-shell/scripts/base16-eighties.dark.sh" ]]; then
  source "$HOME/.config/base16-shell/scripts/base16-eighties.dark.sh"
fi

# Aliases
alias g="git"
alias gclean="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"
alias m="tmuxinator"
alias mux="tmuxinator"
alias t="tmux"
alias be="bundle exec"
alias a="tmux attach -t"

alias vim="nvim"

alias yom="rm -rf node_modules && yarn cache clean && yarn"
alias bom="rm -rf bower_components && bower cache clean && bower install"
alias yombom="yom && bom"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
