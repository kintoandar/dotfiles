# System wide functions and aliases
# Environment stuff goes in /etc/profile

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

# are we an interactive shell?
if [ "$PS1" ]; then
  if [ -z "$PROMPT_COMMAND" ]; then
    case $TERM in
    xterm*|vte*)
      if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
          PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
      elif [ "${VTE_VERSION:-0}" -ge 3405 ]; then
          PROMPT_COMMAND="__vte_prompt_command"
      else
          PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
      fi
      ;;
    screen*)
      if [ -e /etc/sysconfig/bash-prompt-screen ]; then
          PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
      else
          PROMPT_COMMAND='printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
      fi
      ;;
    *)
      [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
      ;;
    esac
  fi
  # Turn on parallel history
  shopt -s histappend
  history -a
  # Turn on checkwinsize
  shopt -s checkwinsize
  [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
  # You might want to have e.g. tty in prompt (e.g. more virtual machines)
  # and console windows
  # If you want to do so, just add e.g.
  # if [ "$PS1" ]; then
  #   PS1="[\u@\h:\l \W]\\$ "
  # fi
  # to your custom modification shell script in /etc/profile.d/ directory
fi

if ! shopt -q login_shell ; then # We're not a login shell
    # Need to redefine pathmunge, it get's undefined at the end of /etc/profile
    pathmunge () {
        case ":${PATH}:" in
            *:"$1":*)
                ;;
            *)
                if [ "$2" = "after" ] ; then
                    PATH=$PATH:$1
                else
                    PATH=$1:$PATH
                fi
        esac
    }

    # By default, we want umask to get set. This sets it for non-login shell.
    # Current threshold for system reserved uid/gids is 200
    # You could check uidgid reservation validity in
    # /usr/share/doc/setup-*/uidgid file
    if [ $UID -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
       umask 002
    else
       umask 022
    fi

    # Only display echos from profile.d scripts if we are no login shell
    # and interactive - otherwise just process them to set envvars
    for i in /etc/profile.d/*.sh; do
        if [ -r "$i" ]; then
            if [ "$PS1" ]; then
                . "$i"
            else
                . "$i" >/dev/null
            fi
        fi
    done

    unset i
    unset -f pathmunge
fi

##########################
# blog.kintoandar.com
##########################

eval `dircolors ~/install/dircolors-solarized/dircolors.256dark`

#PS1='\[\e[3;31m\]\u@\h:\w#\[\e[0m\] '
#JAVA_HOME=/opt/install/jdk1.7.0_45
#PATH=$PATH:/opt/install/protectserver/ETcprt/bin/linux-i386
#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/install/protectserver/ETcprt/lib/linux-i386
#export LD_LIBRARY_PATH PATH
#export ORACLE_HOME="/usr/lib/oracle/11.2/client"
#export LD_LIBRARY_PATH="${ORACLE_HOME}/lib"
#export TNS_ADMIN="${ORACLE_HOME}"

PATH=$PATH:~/.chef/scripts:~/.local/bin

export EDITOR='/usr/bin/vim'
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups erasedups
export HISTSIZE=5000
export HISTFILESIZE=240000

# color man pages
export MANPAGER="/usr/bin/most -s"

# serial
export MINICOM="-m -c on"

# Alias definitions
alias ll='ls -lha --color=auto'
alias vi='vim'
alias ws="python -m SimpleHTTPServer"
alias sshuttle="~/install/sshuttle/sshuttle -r user@localhost:3070 172.20.0.0/16 -D"
alias portecle="java -jar ~/install/portecle-1.7/portecle.jar &"
alias sshconf='vi ~/.ssh/config'
alias json='python -m json.tool'
alias rubyverify='tail -n +2 $1 | ruby -c'
alias diffcookbook='diff -wru $(ls|sort|head -n1) $(ls|sort|tail -n1)|vim -'

# Funky Funcs
passgen(){ < /dev/urandom tr -dc A-Za-z0-9 | head -c${1:-9};echo;}
macgenxen(){ printf '00:16:3E:%02X:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)); }
certexplode(){ awk ' split_after == 1 {n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "cert_" n ".pem"}' < $1 && for I in `ls cert_*` ; do echo -e "------------------\n"; openssl x509 -in $I -text |grep 'C='; done }

# cdargs
source /usr/share/doc/cdargs/examples/cdargs-bash.sh

# ansible
source ~/install/ansible/hacking/env-setup -q
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_NOCOWS=1

# GIT SVN stuff
export GIT_PS1_SHOWDIRTYSTATE=1
source ~/.git-prompt.sh
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
