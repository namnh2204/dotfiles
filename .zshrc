if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://z-shell.pages.dev/docs/gallery/collection
zicompinit # <- https://z-shell.pages.dev/docs/gallery/collection#minimal

zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes @ext-git 


#####################
# PROMPT            #
#####################
zi lucid for \
as"command" from"gh-r" atinit'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' atload'eval "$(starship init zsh)"' bpick'*unknown-linux-gnu*' \
  starship/starship \

##########################
# OMZ Libs and Plugins   #
##########################

# IMPORTANT:
# Ohmyzsh plugins and libs are loaded first as some these sets some defaults which are required later on.
# Otherwise something will look messed up
# ie. some settings help zsh-autosuggestions to clear after tab completion

setopt promptsubst


zi lucid for \
OMZL::history.zsh 
zi wait lucid for \
OMZL::clipboard.zsh \
OMZL::compfix.zsh \
OMZL::completion.zsh \
OMZL::correction.zsh  \
  atload"\
  alias ..='cd ..' \
  alias ...='cd ../..' \
  alias ....='cd ../../..' \
  alias .....='cd ../../../..'" \
OMZL::directories.zsh \
OMZL::git.zsh \
OMZL::grep.zsh \
OMZL::spectrum.zsh \
OMZL::termsupport.zsh \
OMZP::vi-mode \
  atload"\
  export VI_MODE_SET_CURSOR=true" \
OMZP::git \
OMZP::urltools \
OMZP::extract \
OMZP::encode64 \
OMZP::helm \
OMZP::kubectl

zi snippet OMZ::lib/key-bindings.zsh
zi ice lucid wait
zi snippet OMZP::fzf

zi ice as"completion"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi ice as"completion"
zi snippet https://github.com/docker/compose/tree/master/contrib/completion/zsh/_docker-compose


zi snippet OMZ::lib/theme-and-appearance.zsh

zi load z-shell/zui

if [[ `uname` == "Darwin" ]]; then
    eval "$(zoxide init zsh)"
    zi snippet OMZP::fzf/fzf.plugin.zsh
else
    zi ice wait"2" as"command" from"gh-r" lucid \
        mv"zoxide*/zoxide -> zoxide" \
        atclone"./zoxide init zsh > init.zsh" \
        atpull"%atclone" src"init.zsh" nocompile'!'
    zi light ajeetdsouza/zoxide

    zi light-mode for \
        z-shell/z-a-meta-plugins \
        @console-tools

    zi ice as"command" from"gh-r" mv"delta* -> delta" pick"delta/delta"
    zi light dandavison/delta
fi

if command -v nvim &> /dev/null
then
    alias vim="nvim"
    export EDITOR='nvim'
    alias nvimo="nvim -u NORC  --noplugin"
    alias vimo="/usr/bin/vim"
fi

export SDKMAN_DIR="$HOME/.sdkman"
zi ice wait lucid as"program" pick"$HOME/.sdkman/bin/sdk" id-as'sdkman' run-atpull \
    atclone"wget https://get.sdkman.io -O $HOME/.sdkman/scr.sh; bash $HOME/.sdkman/scr.sh" \
    atpull"sdk selfupdate" \
    atinit"source $HOME/.sdkman/bin/sdkman-init.sh"
zi light z-shell/null

zi ice lucid wait as'completion' blockf has'cargo'
zi snippet https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo

zi ice lucid wait as'completion' blockf has'rg'
zi snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

# zi ice pick"async.zsh" src"pure.zsh"
# zi light sindresorhus/pure

zi wait lucid for \
 atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zi ice wait lucid
zi snippet OMZP::nvm

zi ice wait lucid
zi light kazhala/dotbare

ZSH_AUTOSUGGEST_USE_ASYNC=true

zi ice wait lucid
zi snippet "OMZ::lib/completion.zsh"

zi ice wait lucid
zi light "MichaelAquilina/zsh-you-should-use"

zi ice lucid wait has'fzf'
zi light Aloxaf/fzf-tab


export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/bin"

if [[ `uname` == "Darwin" ]]; then
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
    source ~/.iterm2_shell_integration.zsh
    export HOMEBREW_NO_INSTALL_CLEANUP=1
    eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
    export PATH="/usr/local/sbin:$PATH"
    export PATH="/usr/local/opt/icu4c/bin:$PATH"
    export PATH="/usr/local/opt/icu4c/sbin:$PATH"
else
    export PATH=$PATH:/usr/local/go/bin
    alias open=xdg-open
    # Generated for envman. Do not edit.
    [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# nvm config
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#e5c07b,fg+:#98c379,bg+:-1,hl+:#ffaf5f
--color=info:#61afef,prompt:#e06c75,pointer:#98c379,marker:#ff87d7,spinner:#ff87d7
'
export BAT_THEME="TwoDark"

export FZF_DEFAULT_COMMAND='fd --type file'

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

if command -v exa &> /dev/null
then
    alias ls=exa
    alias la=ll -a
fi

if [ "$TMUX" = "" ] && [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ] && [ "$TERM_PROGRAM" != "vscode" ]; then tmux new -As0; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/namnh/google-cloud-sdk/path.zsh.inc' ]; then . '/home/namnh/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/namnh/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/namnh/google-cloud-sdk/completion.zsh.inc'; fi

