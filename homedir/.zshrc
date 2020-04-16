# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh
# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
POWERLEVEL9K_MODE='awesome-fontconfig'
# export ZSH_THEME="spaceship"
export ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY=”truncate_from_right”
# https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon vi_mode dir nvm java_version vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time battery)
POWERLEVEL9K_CUSTOM_ALVIN="echo -e '😎 '"
POWERLEVEL9K_DIR_FOREGROUND='red'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_ALVIN_BACKGROUND="red"
POWERLEVEL9K_CUSTOM_ALVIN_FOREGROUND="yellow"
# colorcode test
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
POWERLEVEL9K_NVM_FOREGROUND='000'
POWERLEVEL9K_NVM_BACKGROUND='072'
POWERLEVEL9K_SHOW_CHANGESET=true

#POWERLEVEL9K_MODE='nerdfont-complete'

#export ZSH_THEME="random"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  colorize
  compleat
  dirpersist
  autojump
  git gulp
  history
  cp
  zsh-syntax-highlighting
  colored-man-pages
  composer
  vi-mode
)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#source /usr/local/opt/nvm/nvm.sh

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    nvm use default &> /dev/null
  fi
}
#add-zsh-hook chpwd load-nvmrc
#load-nvmrc

# Customize to your needs...
unsetopt correct

# run fortune on new terminal :)
fortune

plugins=(zsh-autosuggestions)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# nvbn/thefuck (Auto-correct last command mistake)
eval $(thefuck --alias)


# Copied from .bash_profile
# OVERRIDE ALL VARIABLES, EXPECIALLY FOR LIBTOOL
export PATH=/usr/bin:$PATH

# ANDROID VARIABLES
export ANDROID_HOME=/Users/alvinlee/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH

# MYSQL VARIABLES
# export PATH=/Applications/MAMP/Library/bin:$PATH

# TOMEE VARIABLES
# export CATALINA_HOME=/usr/local/opt/tomee-plus/libexec
# export PATH=/usr/local/opt/tomee-plus/libexec/bin:$PATH

# JBOSS VARIABLES
export JBOSS_HOME=/usr/local/opt/wildfly-as/libexec
export PATH=${PATH}:${JBOSS_HOME}/bin

# PHP and COMPOSER VARIABLES
export PATH=~/.composer/vendor/bin:$PATH
export PATH=/usr/local/opt/php@7.1/bin:$PATH

# FLUTTER
export PATH=$HOME/flutter/bin:$PATH

# VISUAL STUDIO CODE
export PATH=/usr/local/bin/code:$PATH

# ANSIBLE
export ANSIBLE_HOSTS=/etc/ansible/hosts

# NODE VERSION MANAGER
# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh

# RUBY
export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"

# GOLANG
export GOPATH=~/Go_Workspace
export PATH=/usr/local/go/bin:$PATH

# Some aliases
alias goHome='cd ~'
alias art='php artisan'
alias phpunit='vendor/bin/phpunit'
alias chromedev='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir=/tmp/foo --ignore-certificate-errors  --disable-web-security --unsafely-treat-insecure-origin-as-secure=https://localhost'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias ion-a='ionic cordova run android'
alias ion-w='ionic cordova run browser'
alias ion-i='ionic cordova run ios'
alias ion-kill='kill -9 $(lsof -ti :8001-8079)'
alias cdhtdocs='cd /Applications/MAMP/htdocs'
alias vibash='vi ~/.bash_profile'
alias sb='source ~/.bash_profile'
alias ls='ls -la'
alias logstash-filebeat='logstash -f /Users/alvinlee/logstash/logstash.filebeat.conf'
alias ctags="`brew --prefix`/bin/ctags"
alias py3='python3'
alias pi='pip3 install --user'

# font sourcing
source ~/.fonts/*.sh
# source ~/.fonts/*.sh

# Change Command Prompt
function parse_git_branch {
git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Others


# git
  function git_prepare() {
    if [ -n "$BUFFER" ];
      then
        BUFFER="git add -A; git commit -m \"$BUFFER\" && git push"
      fi

    if [ -z "$BUFFER" ];
      then
        BUFFER="git add -A; git commit -v && git push"
    fi

    zle accept-line
  }
  zle -N git_prepare
  bindkey "^g" git_prepare

# tmux
  function tmux_prepare() {
    if [ -n "$BUFFER" ];
      then
        BUFFER="tmux new-session -s \"$BUFFER\" && tmux a -t \"$BUFFER\""
      fi

    if [ -z "$BUFFER" ];
      then
        BUFFER="tmux new-session -s ${PWD##*/} -n editor -d \
                && tmux send-keys -t ${PWD##*/} 'nvim .' C-m \
                && tmux split-window -v -p 1 -t  ${PWD##*/} \
                && tmux a -t ${PWD##*/}"
    fi

    zle accept-line
  }
  zle -N tmux_prepare
  bindkey "^n" tmux_prepare

# up
  function up_widget() {
    BUFFER="cd .."
    zle accept-line
  }
  zle -N up_widget
  bindkey "^k" up_widget

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# added by Anaconda3 5.0.1 installer
# export PATH="/Users/AlvinLee/anaconda3/bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/alvinlee/.sdkman"
[[ -s "/Users/alvinlee/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/alvinlee/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/AlvinLee/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/AlvinLee/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/AlvinLee/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/AlvinLee/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

#unalias some conflicted commands
unalias grv

# using faster powerlevel9k config, for a change of taste, overrrides existing powerlevel9k configs in this current file.
# comment out to use custom powerlevel9K config
# source ~/.purepower


#### SOME ADDITIONAL STUFF
#

source ./zsh_compose/.zsh_java
# source ./zsh_compose/.zsh_java

# export PATH="/Users/alvinlee/Library/Python/3.7/bin:$PATH"
#### END ADDITIONAL STUFF

export PATH=~/.composer/vendor/bin:$PATH
export PATH=/usr/local/opt/php@7.1/bin:$PATH

# FLUTTER
export PATH=$HOME/flutter/bin:$PATH

# VISUAL STUDIO CODE
export PATH=/usr/local/bin/code:$PATH

# ANSIBLE
export ANSIBLE_HOSTS=/etc/ansible/hosts

# NODE VERSION MANAGER
# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh

# RUBY
export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"

# GOLANG
export GOPATH=~/Go_Workspace
export PATH=/usr/local/go/bin:$PATH

# Some aliases
alias ls='ls -la'
alias logstash-filebeat='logstash -f /Users/alvinlee/logstash/logstash.filebeat.conf'
alias ctags="`brew --prefix`/bin/ctags"
alias py3='python3'
alias pi='pip3 install --user'

# Change Command Prompt
function parse_git_branch {
git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Others


# git
  function git_prepare() {
    if [ -n "$BUFFER" ];
      then
        BUFFER="git add -A; git commit -m \"$BUFFER\" && git push"
      fi

    if [ -z "$BUFFER" ];
      then
        BUFFER="git add -A; git commit -v && git push"
    fi

    zle accept-line
  }
  zle -N git_prepare
  bindkey "^g" git_prepare

# tmux
  function tmux_prepare() {
    if [ -n "$BUFFER" ];
      then
        BUFFER="tmux new-session -s \"$BUFFER\" && tmux a -t \"$BUFFER\""
      fi

    if [ -z "$BUFFER" ];
      then
        BUFFER="tmux new-session -s ${PWD##*/} -n editor -d \
                && tmux send-keys -t ${PWD##*/} 'nvim .' C-m \
                && tmux split-window -v -p 1 -t  ${PWD##*/} \
                && tmux a -t ${PWD##*/}"
    fi

    zle accept-line
  }
  zle -N tmux_prepare
  bindkey "^n" tmux_prepare

# up
  function up_widget() {
    BUFFER="cd .."
    zle accept-line
  }
  zle -N up_widget
  bindkey "^k" up_widget

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export WMSJAVA_HOME="/Library/WowzaStreamingEngine-4.7.1/java"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# added by Anaconda3 5.0.1 installer
# export PATH="/Users/AlvinLee/anaconda3/bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/alvinlee/.sdkman"
[[ -s "/Users/alvinlee/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/alvinlee/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/AlvinLee/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/AlvinLee/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/AlvinLee/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/AlvinLee/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

#unalias some conflicted commands
unalias grv

# using faster powerlevel9k config, for a change of taste, overrrides existing powerlevel9k configs in this current file.
# comment out to use custom powerlevel9K config
# source ~/.purepower


#### SOME ADDITIONAL STUFF
#

source ./zsh_compose/.zsh_java

# export PATH="/Users/alvinlee/Library/Python/3.7/bin:$PATH"
export PATH="/Users/alvinlee/Library/Python/3.7/bin:$PATH"
export PYTHONPATH="/Users/alvinlee/Library/Python/3.7/bin"
#### END ADDITIONAL STUFF
export PATH="/usr/local/bin:$PATH"
# using faster powerlevel9k config, for a change of taste, overrrides existing powerlevel9k configs in this current file.
# comment out to use custom powerlevel9K config
# source ~/.purepower


#### SOME ADDITIONAL STUFF
#

source ./zsh_compose/.zsh_java

# export PATH="/Users/alvinlee/Library/Python/3.7/bin:$PATH"
#### END ADDITIONAL STUFF
