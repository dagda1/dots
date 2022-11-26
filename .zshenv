export PATH="$PATH:/bin" 
export PATH="$PATH:~/bin"
export PATH="$PATH:~/.local/bin"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export CC=/usr/bin/gcc

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export ZSH_DISABLE_COMPFIX="true"
export AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"
export GITHUB_TOKEN="$(security find-generic-password -s ghub -a paulcowan -w)"
export NPM_TOKEN="$(security find-generic-password -s npm -a paulcowan -w)"

export POSTGRES_HOST="localhost"
export POSTGRES_USER="postgres"
export POSTGRES_PASSWORD="postgres"
. "$HOME/.cargo/env"
