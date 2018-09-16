# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="lambda-gitster"

. $HOME/.zshenv

plugins=(zsh-nvm git syntax-highlighting iterm2 colored-man-pages yarn vscode frontend-search)

source $ZSH/oh-my-zsh.sh

set -o emacs

. ~/.aliases
