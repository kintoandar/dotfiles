PATH=~/.chef/scripts:~/bin:$PATH

#PS1='\[\033[01;35m\]osx\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
#PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

#PS1='\[\e[32m\]\w$(__git_ps1) \$\[\e[0m\] '
PROMPT_COMMAND='__git_ps1 "\[\e[32m\]\w\[\e[0m\]" " \[\e[32m\]\\\$\[\e[0m\] ";echo -ne "\033]0;${PWD/#$HOME/~}\007"'

# ruby
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# chef
eval "$(chef shell-init bash)"

export LC_ALL="en_US.UTF-8"
export LANG="C"

export EDITOR='/usr/bin/vim'
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups erasedups
export HISTSIZE=11000

# serial
export MINICOM="-m -c on"

# alias definitions
alias ll='ls -lhaG'
alias vi='vim'
#alias proxy="export http_proxy=http://192.168.130.250:8080"
#alias noproxy="export http_proxy=\"\""
#alias ssh-add-all="ssh-add ~/.ssh/id_rsa ~/.ssh/old_2012-02-17/id_rsa ~/.ssh/old_2011-03-25/id_rsa ~/.ssh/old_2013-01-04/id_rsa ~/.ssh/personal/id_rsa_personal" # ssh-agent
alias ws="python -m SimpleHTTPServer"
alias sshuttle="~/Documents/myprojects/cloned/sshuttle/sshuttle -r coreos-vagrant 10.1.0.0/16 -D --python /home/core/bin/python"
alias portecle="java -jar ~/install/portecle-1.7/portecle.jar &"
alias history_clean='history | cut -d" " -f 6-'
alias listservices='systemctl list-unit-files --type=service ; echo -e "\n\n\nsystemctl [disable|enable] blabla.service"'
alias sshconf='vi ~/mount/sync/scripts/dotfiles/.ssh/config'
alias json='python -m json.tool'
alias rubyverify='tail -n +2 $1 | ruby -c'
alias diffcookbook='diff -wr $(ls|sort|head -n1) $(ls|sort|tail -n1)'
alias ns='sudo lsof -n -i4 | grep LISTEN'
alias grep='grep --color=auto'
alias diff='colordiff'
alias wget='wget -c'
alias netstat_osx='sudo lsof -i -n -P | grep LISTEN'
alias foo='foodcritic -I ~/blip/git/chef11/standards/foodcritic-rules/rules.rb $@'
alias activate='source ./env/bin/activate'
alias jk='jekyll serve --watch --verbose'

alias dins='docker inspect -f'
alias drm="docker rm"
alias drmi="docker rmi"
alias dps="docker ps -a"
alias dimg="docker images"
alias dviz="docker images --viz"
alias dtree="docker images --tree"
alias drun="docker run -p 8001:8001 -i -t builder_centos-6.5_betfair /bin/bash"
alias dexec="docker ps;docker exec -it"
alias dui="docker run -d -p 9000:9000 --privileged dockerui/dockerui -e http://coreos01:2375"


if [ $UID -ne 0 ]; then
    alias dmesg='sudo dmesg'
    alias htop='sudo htop'
fi

# Funky Funcs
passgen(){ perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*10000)' | shasum | base64 | head -c 15;echo; }
macgenxen(){ printf '00:16:3E:%02X:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)); }
certexplode(){ awk ' split_after == 1 {n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "cert_" n ".pem"}' < $1 && for I in `ls cert_*` ; do echo -e "------------------\n"; openssl x509 -in $I -text |grep 'C='; done }

# cdargs
function cdb () {
  cdargs "$1" && cd "`cat "$HOME/.cdargsresult"`" ;
}

# git
function gitpullall() {
  CWD=`pwd`; find $PWD -type d -name .git -print0 | xargs -0 -I{} dirname {} | xargs -I{} sh -c 'cd {}; echo "GIT pulling {}"; git pull; git submodule update --recursive'
}
function gitinfoall() {
  CWD=`pwd`; find $PWD -type d -name .git -print0 | xargs -0 -I{} dirname {} | xargs -I{} sh -c 'cd {}; git config --get remote.origin.url'
}

# auto-complete
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# ansible
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_NOCOWS=1

# git-prompt
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto"
source ~/.git-prompt.sh

JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home/
#PATH=$PATH:/opt/install/protectserver/ETcprt/bin/linux-i386
#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/install/protectserver/ETcprt/lib/linux-i386
#export LD_LIBRARY_PATH PATH
#export ORACLE_HOME="/usr/lib/oracle/11.2/client"
#export LD_LIBRARY_PATH="${ORACLE_HOME}/lib"
#export TNS_ADMIN="${ORACLE_HOME}"

# docker
export DOCKER_HOST=tcp://coreos01:2375
#export DOCKER_HOST=tcp://mirage:2375
#export DOCKER_HOST=tcp://coreos2:2375
