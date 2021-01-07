# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="lambda-gitster"

. $HOME/.zshenv

plugins=(
    zsh-nvm
    git
    iterm2
    colored-man-pages
    yarn
    vscode
    frontend-search
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    npm
    jsontools
)

source $ZSH/oh-my-zsh.sh

# disable "sure you want to delete all the files"
setopt rmstarsilent

set -o emacs

. ~/.aliases

. /usr/local/etc/profile.d/z.sh

eval "$(rbenv init -)"
