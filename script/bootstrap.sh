#!/usr/bin/env bash
#
# Enhanced dotfiles bootstrap - links dotfiles and handles .config

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

# Global variables for user choices
OVERWRITE_ALL=false
SKIP_ALL=false

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit 1
}

link_file () {
  local src=$1 dst=$2

  # Validate source exists
  if [ ! -e "$src" ]; then
    fail "Source does not exist: $src"
  fi

  local overwrite=false skip=false
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
  then
    if [ "$OVERWRITE_ALL" != "true" ] && [ "$SKIP_ALL" != "true" ]
    then
      user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all?"
      read -n 1 action
      echo  # Add newline after input

      case "$action" in
        o )
          overwrite=true;;
        O )
          OVERWRITE_ALL=true
          overwrite=true;;
        s )
          skip=true;;
        S )
          SKIP_ALL=true
          skip=true;;
        * )
          skip=true;;
      esac
    fi

    # Apply global settings
    if [ "$OVERWRITE_ALL" == "true" ]; then
      overwrite=true
    fi
    if [ "$SKIP_ALL" == "true" ]; then
      skip=true
    fi

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
      return 0
    fi
  fi

  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$dst")"

  # Create the symlink
  if ln -s "$src" "$dst" 2>/dev/null; then
    success "linked $src to $dst"
  else
    fail "failed to link $src to $dst"
  fi
}

install_regular_dotfiles () {
  info 'installing regular dotfiles'

  for src in $(find -H "$DOTFILES_ROOT" -name '*.symlink' -type f -not -path '*.git*' -not -path '*config.symlink*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

install_config_dotfiles () {
  info 'installing .config dotfiles'

  # Handle config directories (config/appname/ -> ~/.config/appname/)
  for src in $(find -H "$DOTFILES_ROOT/config" -mindepth 1 -maxdepth 1 -type d -not -path '*.git*' 2>/dev/null)
  do
    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"

    # Extract the app name (e.g., config/fish -> fish)
    app_name=$(basename "$src")
    dst="$HOME/.config/$app_name"
    link_file "$src" "$dst"
  done
}

install_homebrew () {
  if [ "$(uname -s)" != "Darwin" ]; then
    return 0
  fi

  info 'checking for Homebrew'

  if ! command -v brew >/dev/null 2>&1
  then
    info 'installing Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success 'Homebrew installed'
  else
    success 'Homebrew already installed'
  fi
}

install_brew_dependencies () {
  if [ "$(uname -s)" != "Darwin" ] || ! command -v brew >/dev/null 2>&1; then
    return 0
  fi

  if [ -f "$DOTFILES_ROOT/Brewfile" ]
  then
    info 'installing Homebrew dependencies'
    if brew bundle --file="$DOTFILES_ROOT/Brewfile"; then
      success 'Homebrew dependencies installed'
    else
      fail 'failed to install Homebrew dependencies'
    fi
  else
    info 'no Brewfile found, skipping Homebrew dependencies'
  fi
}

# Main execution

# macOS-specific installations first
if [ "$(uname -s)" == "Darwin" ]
then
  install_homebrew
  install_brew_dependencies
fi

install_regular_dotfiles
install_config_dotfiles

echo ''
echo '  All installed!'

# Reload the shell environment
info 'reloading shell environment'

# Source the appropriate shell config based on current shell
case "$SHELL" in
  */bash)
    if [ -f "$HOME/.bash_profile" ]; then
      source "$HOME/.bash_profile"
      success 'sourced .bash_profile'
    elif [ -f "$HOME/.bashrc" ]; then
      source "$HOME/.bashrc"
      success 'sourced .bashrc'
    fi
    ;;
  */fish)
    # Fish doesn't use source like bash/zsh, it automatically reloads config
    # We can restart fish if needed
    info 'fish will reload config automatically'
    ;;
  */zsh)
    if [ -f "$HOME/.zshrc" ]; then
      source "$HOME/.zshrc"
      success 'sourced .zshrc'
    fi
    ;;
  *)
    info "unknown shell $SHELL, skipping reload"
    ;;
esac

echo ''
echo '  Shell environment reloaded! You may want to restart your terminal for full effect.'
