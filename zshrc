[ -z "$PS1" ] && return

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
unsetopt beep
#bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/stephan/.zshrc'

# completion options
zstyle ':completion:*' special-dirs true
# set this to rebuild the completion cache every time.
# set this if you are annoyed about the "zsh doesn't complete newly installed
# programs" even though it's a little bit slower
zstyle ":completion:*:commands" rehash 1

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt append_history
setopt SHARE_HISTORY

# Displays the status of background jobs immediately
setopt notify

# Say how long a command took, if it took more than 10 seconds
export REPORTTIME=10

# Background processes aren't killed on exit
setopt AUTO_CONTINUE

# Kill menu
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# pflogsumm menu
zstyle ':completion:*:*:pflogsumm:*' menu yes select
zstyle ':completion:*:pflogsumm:*' force-list always
#zstyle ':completion:*:*:


# color

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

autoload colors
colors

PS1=$'%{\e[0;37m%}%B%*%b %{\e[0;35m%}%m:%{\e[0;37m%}%~ %(!.#.>) %{\e[00m%}'

if [ -f $(which lesspipe) ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# sudo aliases
if [ ! "$USER" = "root" ]; then
    alias easy_install='sudo easy_install'
    alias rabbitmqctl='sudo rabbitmqctl'
    alias apt-get='sudo apt-get'
    alias fd='sudo fdisk'
    alias fdl='sudo fdisk -l'
    alias agi='sudo apt-get install'
    alias updatedb='sudo updatedb'
else
    alias fdl='fdisk -l'
    alias agi='apt-get install'
fi


## functions
function .search() {
    if [ ! $# -eq 2 ]; then
        echo "Usage: .search 'filename.*' 'myText'"
    else
        NCMD="find -iname '$1' -print0|xargs -0 grep -H -i '$2'"
        eval "$NCMD"
    fi
}

function .rabbit_adduser() {
    if [ ! $# -gt 0 ]; then
        echo "Usage: $0 username [password]"
        return 1
    fi
    if [ "$2" = "" ]; then
        PW=$(makepasswd) 2>/dev/null
        if [ ! $? -eq 0 ]; then
            echo "makepasswd is not installed. Please specify the password manually or install makepasswd"
            return 1
        fi
    else
        PW=$2
    fi
    rabbitmqctl add_user $1 $PW
    if [ $? -eq 0 ]; then
        echo "Created new user with password: $PW"
    fi
}    

function .apt_profile() {
    # I use apt-cacher-ng at home because i live in the middle of nowhere
    # with a slow internet connection. I can change the apt profile here
    # to not have to edit the sources.list manually when i'm not at home.
    APT_PROFILES=$(ls /etc/apt/sources.list-profile.*|sed 's/.*sources.list-profile\.//g')
    if [ $# -eq 0 ]; then
        echo "Change apt profile"
        if [ "$APT_PROFILES" = "" ]; then
            echo "There are currently no profiles installed. Just create a new"
            echo "file called sources.list-profile.yourprofilename in /etc/apt/"
        else
            echo "Available profiles are:"
            for P in $APT_PROFILES; do
                echo "$P"
            done 
        fi
    else
        FILEN=/etc/apt/sources.list-profile.$1
        if [ ! -f $FILEN ]; then
            echo "Profile $1 not found."
            return 1
        else
            if [ -L /etc/apt/sources.list ]; then
                LNK=$(readlink /etc/apt/sources.list|grep "sources\.list-profile\.")
                echo $LNK
                if [ ! "$LNK" = "" ]; then
                    CH_CMD="rm /etc/apt/sources.list; ln -s /etc/apt/sources.list-profile.$1 /etc/apt/sources.list;"
                    if [ "$USER" = "root" ]; then
                        eval "$CH_CMD"
                        apt-get update
                        return 0
                    else
                        eval "sudo zsh -c \"$CH_CMD\""
                        sudo apt-get update
                        return 0
                    fi
                else 
                    echo "I politely refuse to overwrite a non-profile sources.list. Make a symbolic link to a profile (e.g. ln -s sources.list-profile.$1 sources.list ) manually so i can change between them." 
                fi
            else
                echo "I politely refuse to overwrite a non-profile sources.list. Make a symbolic link to a profile (e.g. ln -s sources.list-profile.$1 sources.list ) manually so i can change between them." 
            fi
        fi
    fi
}

# aliases
alias du.='du -sh .'
alias sl='ls'
alias v='vim -O'
alias psg='ps faux |grep -i'
alias la='ls -la'
alias lh='ls -lah'
alias ll='ls -l'
alias l='ls'
alias acs='apt-cache search'
alias show='apt-cache show'
alias 'du*'="du -sh *"
alias 'dus'="du -s *|sort -n"

# scripts
alias .ren='~/.scripts/rename_and_move.py'
