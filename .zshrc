# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate _prefix _yaourt
zstyle ':completion:*' completions 1
zstyle ':completion:*' condition 0
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous false
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/daniel/.zshrc'

#Aliases
alias lb='ls++'
alias le='ls++ -A'
alias sl='noglob sl'
alias lsi='LS_COLORS=$(python2 $HOME/.local/bin/ls_colors_generator) ls-i --color=auto'
alias diri='LS_COLORS=$(python2 $HOME/.local/bin/ls_colors_generator) dir-i --color=auto'
alias vdiri='LS_COLORS=$(python2 $HOME/.local/bin/ls_colors_generator) vdir-i --color=auto'

alias palf='pacaur -Ql'
alias pacman-disowned-files="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type f -print | sort -u) <(pacman -Qlq | sort -u)"
alias pacman-disowned-dirs="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type d -print | sed 's/\([^/]\)$/\1\//' | sort -u) <(pacman -Qlq | sort -u)"

alias svim='sudo -E nvim'
alias vim="nvim"

alias prconf='pacaur -C'        # Fix all configuration files with vimdiff
# Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
alias prupg='pacaur -Syu'        # Synchronize with repositories before upgrading packages (AUR packages too) that are out of date on the local system.
alias prin='pacaur -S'           # Install specific package(s) from the repositories
alias prins='pacaur -U'          # Install specific package not from the repositories but from a file
alias prre='pacaur -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias prrem='pacaur -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias prrep='pacaur -Si'         # Display information about a given package in the repositories
alias prreps='pacaur -Ss'        # Search for package(s) in the repositories
alias prloc='pacaur -Qi'         # Display information about a given package in the local database
alias prlocs='pacaur -Qs'        # Search for package(s) in the local database
alias prlst='pacaur -Qe'         # List installed packages, even those installed from AUR (they're tagged as "local")
alias prorph='pacaur -Qtd'       # Remove orphans using yaourt

user_commands=(
  list-units is-active status show help list-unit-files
  is-enabled list-jobs show-environment cat list-timers
  start stop reload restart try-restart isolate kill
  reset-failed enable disable reenable preset mask unmask
  link load cancel set-environment unset-environment
  edit)

for c in $user_commands; do; alias scu-$c="systemctl --user $c"; done
alias scu-enable-now="scu-enable --now"
alias scu-disable-now="scu-disable --now"
alias scu-mask-now="scu-mask --now"
alias scu-daemon-reload="systemctl --user daemon-reload"

#Variables
export SSH_ASKPASS="/usr/bin/ksshaskpass"
export EDITOR="nvim"
export PATH="$(cope_path):/usr/lib/cw:$PATH"
export CCACHE_PATH="/usr/bin"
export TERM=konsole-256color
export SPROMPT='zsh: correct %F{1}%R%f to %F{2}%r%f [nyae]? '
export ENHANCD_COMMAND=ecd
export R_MAX_NUM_DLLS=500
export MANPAGER="nvim -c 'set ft=man' -"
#export PATH="/usr/lib/colorgcc/bin/:$PATH" 

#Base16
#BASE16_SHELL=$HOME/.config/base16-shell/
#[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

#source $HOME/.config/bspwm/base16-tomorrow-night.sh

source "$HOME/.zplug/init.zsh"

#Prezto
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/prompt", from:prezto
zstyle ':prezto:*:*' color 'yes'

#Prezto extra
zplug "modules/helper", from:prezto
zplug "modules/ocaml", from:prezto
zplug "modules/perl", from:prezto
zplug "modules/python", from:prezto
zplug "modules/rsync", from:prezto
zplug "modules/ruby", from:prezto
#zplug "modules/archive", from:prezto broken
#zplug "modules/git", from:prezto broken
#zplug "modules/ssh", from:prezto
#zplug "modules/tmux", from:prezto
    
#Colors
zplug "plugins/colorize", from:oh-my-zsh 
zplug "plugins/colored-man", from:oh-my-zsh 
#zplug "plugins/catimg" from:oh-my-zsh 
#zplug "plugins/command-not-found" from:oh-my-zsh

#Copy
zplug "plugins/copydir", from:oh-my-zsh 
zplug "plugins/copyfile", from:oh-my-zsh 
zplug "plugins/cp", from:oh-my-zsh 
zplug "plugins/rsync", from:oh-my-zsh 

#Perl
zplug "plugins/cpanm", from:oh-my-zsh, lazy:true
zplug "plugins/perl", from:oh-my-zsh, from:oh-my-zsh

#Directories
zplug "b4b4r07/enhancd", use:init.sh
zplug "plugins/dircycle", from:oh-my-zsh 
zplug "plugins/dirhistory", from:oh-my-zsh 
zplug "plugins/jump", from:oh-my-zsh 
zplug "plugins/wd", from:oh-my-zsh 
zplug "plugins/z", from:oh-my-zsh 
zplug "psprint/zsh-navigation-tools"
zplug "Tarrasch/zsh-bd"
#zplug "plugins/fasd", from:oh-my-zsh 

#Archive
zplug "plugins/extract", from:oh-my-zsh 

#Git
zplug "plugins/git", from:oh-my-zsh 

#Go
zplug "plugins/golang", from:oh-my-zsh, lazy:true

#Haskell
zplug "plugins/cabal", from:oh-my-zsh, lazy:true

#History
zplug "plugins/history-substring-search", from:oh-my-zsh 
zplug "plugins/history", from:oh-my-zsh 
zplug "psprint/history-search-multi-word"
zplug "tarruda/zsh-autosuggestions"

#Python
zplug "plugins/pep8", from:oh-my-zsh 
zplug "plugins/python", from:oh-my-zsh 
zplug "plugins/pip", from:oh-my-zsh 
zplug "plugins/pyenv", from:oh-my-zsh 
zplug "plugins/virtualenv", from:oh-my-zsh, lazy:true
#zplug oh-my-zsh "plugins/pylinst"
#zplug, from:oh-my-zsh "plugins/virtualenvwrapper"

#Miscellaneous
zplug "bhilburn/powerlevel9k"
zplug "djui/alias-tips"
zplug "hchbaw/zce.zsh"
zplug "jimmijj/zsh-syntax-highlighting"
zplug "jreese/zsh-titles"
zplug "mafredri/zsh-async", lazy:true
zplug "plugins/catimg", from:oh-my-zsh, lazy:true
zplug "plugins/taskwarrior", from:oh-my-zsh, lazy:true
zplug "plugins/themes", from:oh-my-zsh, lazy:true
zplug "plugins/kate", from:oh-my-zsh 
#zplug "plugins/vi-mode", from:oh-my-zsh 
zplug "plugins/zsh_reload", from:oh-my-zsh 
zplug "psprint/zsnapshot"
zplug "psprint/ztrace"
zplug "Tarrasch/zsh-functional"
zplug "vifon/deer", lazy:true
zplug "willghatch/zsh-snippets"
zplug "zsh-users/zaw"
zplug "joel-porquet/zsh-dircolors-solarized"
#zplug "Valiev/almostontop"
#zplug, from:oh-my-zsh "plugins/safe-paste"
#zplug oh-my-zsh "plugins/web-search"
#zplug "joepvd/grep2awk", nice:10
#zplug load" Angelmmiguel/pm"
#zplug load" marzocchi/zsh-notify"

#System
zplug "plugins/archlinux", from:oh-my-zsh 
zplug "plugins/systemadmin", from:oh-my-zsh 
zplug "plugins/systemd", from:oh-my-zsh 
zplug "plugins/sudo", from:oh-my-zsh 

#Tmux
zplug "plugins/tmux", from:oh-my-zsh 
zplug "plugins/tmuxinator", from:oh-my-zsh 

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load 

#Autosuggest
bindkey '^f' forward-word
bindkey '^b' backward-word
bindkey '^e' end-of-line
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
ZSH_AUTOSUGGEST_USE_ASYNC=true

#Dircolors
setupsolarized dircolors.ansi-light

#Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# PM functions
source ~/.pm/pm.zsh
alias pma="pm add"
alias pmg="pm go"
alias pmrm="pm remove"
alias pml="pm list"
# end PM

#Powerlevel 
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_COLOR_SCHEME="light"
#POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="007"
#POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="011"
#POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="011"
#POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="007"
#POWERLEVEL9K_DIR_HOME_FOREGROUND="011"
#POWERLEVEL9K_DIR_HOME_BACKGROUND="007"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="011"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="007"
#POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
#POWERLEVEL9K_STATUS_OK_BACKGROUND="007"
#POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="007"
#POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="007"

POWERLEVEL9K_CONTEXT_BOLD=true
POWERLEVEL9K_DIR_BOLD=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_BACKGROUND_JOBS_BOLD=true
POWERLEVEL9K_ROOT_INDICATOR_BOLD=true
POWERLEVEL9K_HISTORY_BOLD=true
POWERLEVEL9K_VCS_BOLD=true

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs vcs)


#Prezto
#zstyle ':prezto:module:editor' key-bindings 'vi'

#Powerlevel
source ".zplug/repos/bhilburn/powerlevel9k/powerlevel9k.zsh-theme"

#Powerline
#if [ ! $(pgrep powerline-daemo) ]; then
    #powerline-daemon
#fi
#. /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

#SSH
eval $(keychain --eval --quiet ~/.ssh/id_hoffman2 ~/.ssh/id_orion ~/.ssh/id_rsa_icnn ~/.ssh/coppolab ~/.ssh/mistachie777)
