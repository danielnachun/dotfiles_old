# Checks if a name is a command, function, or alias.
function is-callable {
    (( $+commands[$1] )) || (( $+functions[$1] )) || (( $+aliases[$1] ))
}

if is-callable 'dircolors'; then
    # GNU Core Utilities
    alias ls='ls --group-directories-first'

    if [[ -s "$HOME/.dir_colors" ]]; then
        eval "$(dircolors --sh "$HOME/.dir_colors")"
    else
        eval "$(dircolors --sh)"
    fi

    alias ls="${aliases[ls]:-ls} --color=auto"

else
    # BSD Core Utilities
    # Define colors for BSD ls.
    export LSCOLORS='exfxcxdxbxGxDxabagacad'
    # Define colors for the completion system.
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
    alias ls="${aliases[ls]:-ls} -G"
fi

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

autoload -Uz compinit
compinit
autoload -U promptinit
promptinit

# End of lines added by compinstall

#Completion garbage
# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
return 1
fi
# Add zsh-completions to $fpath.
fpath=("${0:h}/external/src" $fpath)
# Load and initialize the completion system ignoring insecure directories.
autoload -Uz compinit && compinit -i
#
# Options
#
setopt COMPLETE_IN_WORD # Complete from both ends of a word.
setopt ALWAYS_TO_END # Move cursor to the end of a completed word.
setopt PATH_DIRS # Perform path search even on command names with slashes.
setopt AUTO_MENU # Show completion menu on a successive tab press.
setopt AUTO_LIST # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL # Disable start/stop characters in shell editor.
#
# Styles
#
# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"
# Case-insensitive (all), partial-word, and then substring completion.
if zstyle -t ':prezto:module:completion:*' case-sensitive; then
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
setopt CASE_GLOB
else
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB
fi
# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# Directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
# Environmental Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
# Populate hostname completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
mailman mailnull mldonkey mysql nagios \
named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
operator pcap postfix postgres privoxy pulse pvm quagga radvd \
rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'
# ... unless we really want to.
zstyle '*' single-ignored show
# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'
# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
# Media Players
zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'
# Mutt
if [[ -s "$HOME/.mutt/aliases" ]]; then
zstyle ':completion:*:*:mutt:*' menu yes select
zstyle ':completion:*:mutt:*' users ${${${(f)"$(<"$HOME/.mutt/aliases")"}#alias[[:space:]]}%%[[:space:]]*}
fi
# SSH/SCP/RSYNC
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

setopt extendedglob
setopt correct
setopt AUTO_CD # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME # Push to home directory when no argument is given.
setopt CDABLE_VARS # Change directory to a path stored in a variable.
setopt AUTO_NAME_DIRS # Auto add variable-stored paths to ~ list.
setopt MULTIOS # Write to multiple descriptors.
setopt EXTENDED_GLOB # Use extended globbing syntax.
unsetopt CLOBBER # Do not overwrite existing files with > and >>.
# Use >! and >>! to bypass.
bindkey -v
# End of lines configured by zsh-newuser-install

#
# Smart URLs
#
#autoload -Uz url-quote-magic
#zle -N self-insert url-quote-magic

#
# General
#
setopt BRACE_CCL # Allow brace character class list expansion.
setopt COMBINING_CHARS # Combine zero-length punctuation characters (accents)
# with the base character.
setopt RC_QUOTES # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING # Don't print a warning message if a mail file has been accessed.

#
# Jobs
#
setopt LONG_LIST_JOBS # List jobs in the long format by default.
setopt AUTO_RESUME # Attempt to resume existing job before creating a new process.
setopt NOTIFY # Report status of background jobs immediately.
unsetopt BG_NICE # Don't run all background jobs at a lower priority.
unsetopt HUP # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS # Don't report on jobs when shell exit.

#
# Termcap
#
export LESS_TERMCAP_mb=$'\E[01;31m' # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m' # Begins bold.
export LESS_TERMCAP_me=$'\E[0m' # Ends mode.
export LESS_TERMCAP_se=$'\E[0m' # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m' # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m' # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m' # Begins underline.

# Checks if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
    ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}


# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
    [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Prints the first non-empty string in the arguments array.
function coalesce {
    for arg in $argv; do
    print "$arg"
    return 0
    done
    return 1
}

# Makes a directory and changes to it.
function mkdcd {
    [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
    builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
    builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pops an entry off the directory stack and lists its contents.
function popdls {
    builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Prints columns 1 2 3 ... n.
function slit {
    awk "{ print ${(j:,:):-\$${^@}} }"
}

# Finds files and executes a command on them.
function find-exec {
    find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
    ps -U "${1:-$LOGNAME}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

#Aliases
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gcc='nocorrect gcc'
alias gist='nocorrect gist'
alias grep='nocorrect grep'
alias heroku='nocorrect heroku'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias rm='nocorrect rm'

# Disable globbing.
alias bower='noglob bower'
alias fc='noglob fc'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'

# Define general aliases.
alias _='sudo'
alias b='${(z)BROWSER}'
alias cp="${aliases[cp]:-cp} -i"
alias e='${(z)VISUAL:-${(z)EDITOR}}'
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias p='${(z)PAGER}'
alias po='popd'
alias pu='pushd'
alias rm="${aliases[rm]:-rm} -i"

alias type='type -a'
# ls

alias l='ls -1A' # Lists in one column, hidden files.
alias ll='ls -lh' # Lists human readable sizes.
alias lr='ll -R' # Lists human readable sizes, recursively.
alias la='ll -A' # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB' # Lists sorted by extension (GNU only).
alias lk='ll -Sr' # Lists sorted by size, largest last.
alias lt='ll -tr' # Lists sorted by date, most recent last.
alias lc='lt -c' # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u' # Lists sorted by date, most recent last, shows access time.
#alias sl='ls' # I often screw this up.

# Grep
export GREP_COLOR='37;45' # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.
alias grep="${aliases[grep]:-grep} --color=auto"

alias o='xdg-open'
if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

# File Download
if (( $+commands[curl] )); then
    alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
    alias get='wget --continue --progress=bar --timestamping'
fi

# Resource Usage
alias df='df -kh'
alias du='du -kh'
alias top=htop

# Miscellaneous
# Serves a directory via HTTP.
alias http-serve='python -m SimpleHTTPServer'

#Rsync
_rsync_cmd='rsync --verbose --progress --human-readable --compress --archive --hard-links --one-file-system'

if grep -q 'xattrs' <(rsync --help 2>&1); then
    _rsync_cmd="${_rsync_cmd} --acls --xattrs"
fi

alias rsync-copy="${_rsync_cmd}"
alias rsync-move="${_rsync_cmd} --remove-source-files"
alias rsync-update="${_rsync_cmd} --update"
alias rsync-synchronize="${_rsync_cmd} --update --delete"
unset _rsync_cmd

#
# Functions
#

alias lb='ls++'
alias le='ls++ -A'
alias sl='noglob sl'

#alias convert="noglob convert"
alias yalf='yaourt -Ql'
alias pacman-disowned-files="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type f -print | sort -u) <(pacman -Qlq | sort -u)"
alias pacman-disowned-dirs="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type d -print | sed 's/\([^/]\)$/\1\//' | sort -u) <(pacman -Qlq | sort -u)"

#alias reboot='sudo systemctl reboot'
#alias poweroff='sudo systemctl poweroff'
#alias root='sudo -s' alias scat='sudo cat'

alias svim='sudo -E vim'
alias sv='sudo -E v'
alias ..='cd ..'
alias getsum='awk -F ' ' '{print $1}' | pbc'
alias ipython='PYTHONPATH=/home/daniel/.virtualenvs/venv/lib/python3.5/site-packages/ ipython'
alias jupyter='PYTHONPATH=/home/daniel/.virtualenvs/venv/lib/python3.5/site-packages/ jupyter'
#alias vim="vim --servername VIM"

alias prconf='pacaur -C'        # Fix all configuration files with vimdiff
# Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
alias prupg='pacaur -Syu'        # Synchronize with repositories before upgrading packages (AUR packages too) that are out of date on the local system.
#alias prsu='pacaur --sucre'      # Same as prupg, but without confirmation
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

export SSH_ASKPASS=""
export EDITOR="vim"
export PATH="$(cope_path):$PATH"
export PATH="/home/daniel/.cabal/bin:$PATH"
export PATH="/usr/lib/jvm/java-7-openjdk/bin:$PATH"
export PATH="/home/daniel/abs/v-master/:$PATH"
export PATH="/home/daniel/R/x86_64-pc-linux-gnu-library/3.2/nvimcom/bin/:$PATH"
export CCACHE_PATH="/usr/bin"
export GTK_DISABLE_CSD=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.gtkthemefile=/home/daniel/.gtkrc-2.0"
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk/
export TERM=xterm-256color
export ALLOW_WGCNA_THREADS=8
export SPROMPT='zsh: correct %F{1}%R%f to %F{2}%r%f [nyae]? '
export HOSTNAME=$(hostname)

alias vm='f -e vim'
#for font debug use -Dsun.java2d.debugfonts
#export SAL_USE_VCLPLUGIN=gtk lowriter
export PATH="/usr/lib/jvm/java-7-openjdk/jre/:/usr/lib/jvm/java-7-openjdk/jre/bin/:/usr/lib/jvm/java-7-openjdk/jre/lib/:$PATH"
export LD_LIBRARY_PATH="/usr/lib/jvm/java-7-openjdk/jre/lib/amd64/server:/usr/lib/jvm/java-7-openjdk/jre/lib/amd64:$LD_LIBRARY_PATH"
#export PATH="/usr/lib/colorgcc/bin/:$PATH" 
#export PATH="/opt/wine-compholio/bin/:$PATH"
#export PATH="/home/daniel/.ghc/x86_64-linux-7.8.3/.cabal-sandbox/bin:$PATH"

#export LESS_TERMCAP_mb=$'\E[01;31m' \
#LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#LESS_TERMCAP_me=$'\E[0m' \
#LESS_TERMCAP_se=$'\E[0m' \
#LESS_TERMCAP_so=$'\E[38;5;246m' \
#LESS_TERMCAP_ue=$'\E[0m' \
#LESS_TERMCAP_us=$'\E[04;38;5;146m' \

wcd ()
{
    /usr/bin/wcd.exe "$@"
    . ${WCDHOME:-${HOME}}/bin/wcd.go
}

wcl ()
{
    /usr/bin/wcd.exe "$@"
    . ${WCDHOME:-${HOME}}/bin/wcd.go
    ls
}

wcdg ()
{
    /usr/bin/wcd.exe -g -Tc -K "$@"
    . ${WCDHOME:-${HOME}}/bin/wcd.go
}

# cd and ls in one
cl() {
    dir=$1
    if [[ -z "$dir" ]]; then
        dir=$HOME
    fi
    if [[ -d "$dir" ]]; then
        cd "$dir"
        ls
    else
        echo "zsh: cl: '$dir': Directory not found"
    fi
}

function ghc-pkg-reset() {
  if [[ $(readlink -f /proc/$$/exe) =~ zsh ]]; then
    read 'ans?Erasing all your user ghc and cabal packages - are you sure (y/N)? '
  else # assume bash/bash compatible otherwise
    read -p 'Erasing all your user ghc and cabal packages - are you sure (y/N)? ' ans
  fi

  [[ x$ans =~ "xy" ]] && ( \
    echo 'erasing directories under ~/.ghc'; command rm -rf `find ~/.ghc/* -maxdepth 1 -type d`; \
    echo 'erasing ~/.cabal/lib'; command rm -rf ~/.cabal/lib; \
  )
}

#. /home/daniel/abs/z-master/z.sh

if [ "x$DISPLAY" != "x" ]
then
    if [ "$HAS_256_COLORS" = "yes" ]
    then
        function tvim(){ tmux new-session "TERM=screen-256color vim --servername VIM $@" ; }
    else
        function tvim(){ tmux new-session "vim --servername VIM $@" ; }
    fi
else
    if [ "$HAS_256_COLORS" = "yes" ]
    then
        function tvim(){ tmux new-session "TERM=screen-256color vim $@" ; }
    else
        function tvim(){ tmux new-session "vim $@" ; }
    fi
fi

export DISABLE_AUTO_UPDATE="true"

source "$HOME/.zgen/zgen/zgen.zsh"
if ! zgen saved; then
    #zgen prezto * color 'yes'
    #zgen prezto prompt theme 'sorin'
    #zgen prezto editor key-bindings 'vi'
    
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/catimg
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/colorize
    zgen oh-my-zsh plugins/colored-man
    zgen oh-my-zsh plugins/copydir
    zgen oh-my-zsh plugins/copyfile
    zgen oh-my-zsh plugins/cp #use cpv
    zgen oh-my-zsh plugins/cpanm
    zgen oh-my-zsh plugins/dircycle
    zgen oh-my-zsh plugins/dirhistory
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/fasd
    zgen oh-my-zsh plugins/golang
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/history
    zgen oh-my-zsh plugins/jump
    zgen oh-my-zsh plugins/kate
    zgen oh-my-zsh plugins/pep8
    zgen oh-my-zsh plugins/perl
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/python
 #   zgen oh-my-zsh plugins/pylinst
    zgen oh-my-zsh plugins/pyenv
    zgen oh-my-zsh plugins/rsync
    #zgen oh-my-zsh plugins/safe-paste
    zgen oh-my-zsh plugins/systemadmin
    zgen oh-my-zsh plugins/systemd
    zgen oh-my-zsh plugins/taskwarrior
    zgen oh-my-zsh plugins/themes
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/tmuxinator
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/virtualenv
    #zgen oh-my-zsh plugins/virtualenvwrapper
    zgen oh-my-zsh plugins/vundle
    zgen oh-my-zsh plugins/wd
 #   zgen oh-my-zsh plugins/web-search
    zgen oh-my-zsh plugins/zsh_reload
    zgen oh-my-zsh plugins/catimg
    zgen oh-my-zsh plugins/cabal
    zgen oh-my-zsh plugins/archlinux
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/z
    #zgen oh-my-zsh plugins/zsh-autosuggestions
    
    zgen load tarruda/zsh-autosuggestions
    zgen load jimmijj/zsh-syntax-highlighting
    zgen load vifon/deer
    zgen load Tarrasch/zsh-bd
    zgen load Tarrasch/zsh-functional
    #zgen load Angelmmiguel/pm
    #zgen load marzocchi/zsh-notify
    zgen save
fi

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
#zle-line-init() {
    #zle autosuggest-start
#}
zle -N zle-line-init

bindkey '^f' vi-forward-word
bindkey '^e' end-of-line
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey '^R' history-incremental-search-backward
#bindkey "${terminfo[khome]}" beginning-of-line
#bindkey "${terminfo[kend]}" end-of-line
#bindkey "${terminfo[home]}" beginning-of-line
#bindkey "${terminfo[end]}" end-of-line
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
#autosuggest_start

POWERLINE_SHELL_CONTINUATION=1
POWERLINE_SHELL_SELECT=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
if [ ! $(pgrep powerline-daemo) ]; then
    powerline-daemon
fi
. /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
#export ZLE_RPROMPT_INDENT=0
export LC_ALL=en_US.UTF-8
#zle -N zle-keymap-select

alias v='/home/daniel/abs/v-master/v'

# OPAM configuration
#. /home/daniel/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}



# PM functions
source ~/.pm/pm.zsh
alias pma="pm add"
alias pmg="pm go"
alias pmrm="pm remove"
alias pml="pm list"
# end PM
