# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="lambda-gitter"

. $HOME/.zshenv

plugins=(zsh-nvm git syntax-highlighting)

source $ZSH/oh-my-zsh.sh

set -o emacs

. ~/.aliases
