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

source ~/.install-plugins

plugins=(
    git
    iterm2
    colored-man-pages
    yarn
    vscode
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

. ~/.aliases

. /opt/homebrew/etc/profile.d/z.sh

eval "$(rbenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

CPLUS_INCLUDE_PATH=/opt/homebrew/include
PKG_CONFIG_PATH=/opt/homebrew/lib/pkgconfig

eval "$(/opt/homebrew/bin/brew shellenv)"

. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
. "/Users/paulcowan/.deno/env"