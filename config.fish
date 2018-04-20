# Authors:
#   Will Raxworthy

source ~/.asdf/asdf.fish

# Source base16 256 colourspace script.
if status --is-interactive
  eval sh "$HOME/.config/base16-shell/scripts/base16-material.sh"
end

# Aliases
alias g="git"
alias gclean="git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d"
alias m="tmuxinator"
alias t="tmux"
alias be="bundle exec"
alias a="tmux attach -t"
alias vim="nvim"

function fish_prompt
  echo
  set_color blue
  echo (dirs)
  set_color purple
  echo '❯ '
end
