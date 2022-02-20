# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# ZSH_THEME="lambda-gitster"
# ZSH_THEME="xiong-chiamiov"
# ZSH_THEME="xiong-chiamiov-plus"
ZSH_THEME="powerlevel10k/powerlevel10k"

. $HOME/.zshenv

plugins=(
    git
    iterm2
    colored-man-pages
    yarn
    vscode
    frontend-search
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    zsh-volta
    npm
    jsontools
)

source $ZSH/oh-my-zsh.sh
source ./.my-zshenv

# disable "sure you want to delete all the files"
setopt rmstarsilent

set -o emacs

. ~/.aliases

. /usr/local/etc/profile.d/z.sh

eval "$(rbenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
