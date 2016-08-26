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
if [[ -s "$HOME/.colours/base16-shell/base16-eighties.dark.sh" ]]; then
  source "$HOME/.colours/base16-shell/base16-eighties.dark.sh"
fi

# Aliases
alias g="git"
alias m="tmuxinator"
alias mux="tmuxinator"
alias t="tmux"
alias be="bundle exec"
alias a="tmux attach -t"

alias nom="rm -rf node_modules && npm cache clean && npm install"
alias bom="rm -rf bower_components && bower cache clean && bower install"
alias nombom="nom && bom"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL
