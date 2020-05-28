# Dotfiles

Installation:

```shell
git clone git@github.com:willrax/dotfiles.git
```

- Copy the `gitconfig.sample` into `gitconfig` and update the name, email, and paths.
- Run `ruby launch.rb`

## Homebrew

Install Homebrew with this command:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

In the dotfiles folder run `brew bundle`.

## Prezto

To install Prezto run:

```shell
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

## Colors

I use base16 shell. To install the color palette run:

```shell
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
```

## iTerm 2

Load the iterm.json profile file in to iTerm 2.

## Fonts

I use [Dank Mono](https://dank.sh/).

## Tool Versions

To manage language versions I use [asdf](https://asdf-vm.com/). Globally used versions are kept in .tool-versions. To install asdf run:

```shell
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch [LATEST-VERSION]
```

Then to install all required versions run:

```shell
asdf install
```

# Other Settings

- Enable key repeat in VSCode

```shell
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

- Change trackpad sensitivity to 6
- Change key repeat and press delay to max
- Add spaces to dock

```shell
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
```
