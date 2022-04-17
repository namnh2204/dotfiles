#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
zsh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/namnh/.sdkman"
[[ -s "/home/namnh/.sdkman/bin/sdkman-init.sh" ]] && source "/home/namnh/.sdkman/bin/sdkman-init.sh"
