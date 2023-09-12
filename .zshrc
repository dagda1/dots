# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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
    pnpm
    jsontools
    z
)

source $ZSH/oh-my-zsh.sh

source ~/.my-zshenv

# disable "sure you want to delete all the files"
setopt rmstarsilent

echo "export EDITOR=/usr/bin/vim" >> ~/.zshrc
echo "export VISUAL=/usr/bin/vim" >> ~/.zshrc

. ~/.aliases

. /opt/homebrew/etc/profile.d/z.sh

eval "$(rbenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
CPLUS_INCLUDE_PATH=/opt/homebrew/include
PKG_CONFIG_PATH=/opt/homebrew/lib/pkgconfig

eval "$(/opt/homebrew/bin/brew shellenv)"

# pnpm
export PNPM_HOME="/Users/paulcowan/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
