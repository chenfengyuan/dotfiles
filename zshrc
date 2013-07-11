# -*- mode: shell-script;-*-
#设置OpenResty环境变量
export OPENRESTY_HOME=/Users/chenfengyuan/appwill/openresty/

#设置Moochine环境变量
export MOOCHINE_HOME=/Users/chenfengyuan/appwill/moochine

#设置Haddit环境变量
export HADDIT_HOME=/Users/chenfengyuan/appwill/private/haddit
KERNEL=`uname -s|tr 'A-Z' 'a-z'`
export LANG=en_US.UTF-8

case $KERNEL in
    "darwin")
	export PATH=$HOME/.local/bin:/usr/local/sbin:/Applications/Emacs.app/Contents/MacOS/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$HOME/.bin:~/perl5/bin:$PATH:/usr/local/share/npm/bin;;
    "linux")
	export PATH=/usr/local/bin/:$HOME/.local/bin:$PATH:/usr/local/share/npm/bin/:/gensym/bin/;;
esac
export PERL5LIB=~/perl5/lib/perl5
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:/usr/local/share/man/:$MANPATH
# export PATH="/usr/lib/ccache/bin/:/usr/lib/distcc/bin/:${PATH}"
# export INFOPATH=$INFOPATH:$HOME/info
#关于历史纪录的配置 {{{
#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000
#export HISTFILE=~/.histfile
export HISTFILE=~/.zhistory
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS      
#为历史纪录中的命令添加时间戳      
setopt EXTENDED_HISTORY      

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#杂项 {{{
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      

setopt hash_list_all # search all paths before command completion
#禁用 core dumps
limit coredumpsize 0

#方便得前后台切换，来自于roylez
bindkey -s "" "fg\n"

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
#}}}

#自动补全功能 {{{
setopt AUTO_LIST
setopt AUTO_MENU
autoload -U compinit
compinit

#自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _force_rehash _complete _prefix _correct _prefix _match _approximate 

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

#彩色补全菜单 
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# completion for kill  
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组 
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
#}}}

##行编辑高亮模式 {{{
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域 
special:bold      #特殊字符
isearch:underline)#搜索时使用的关键字
#}}}

##空行(光标在行首)补全 "cd " {{{
user-complete(){
    case $BUFFER in
        "" )                       # 空行填入 "cd "
        BUFFER="cd "
        zle end-of-line
        zle expand-or-complete
        ;;
        "cd --" )                  # "cd --" 替换为 "cd +"
        BUFFER="cd +"
        zle end-of-line
        zle expand-or-complete
        ;;
        "cd +-" )                  # "cd +-" 替换为 "cd -"
        BUFFER="cd -"
        zle end-of-line
        zle expand-or-complete
        ;;
        * )
        zle expand-or-complete
        ;;
    esac
}
zle -N user-complete
bindkey "\t" user-complete
#}}}

# ##在命令前插入 sudo {{{
# #定义功能 
# sudo-command-line() {
#     [[ -z $BUFFER ]] && zle up-history
#     [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
#     zle end-of-line                 #光标移动到行末
# }
# zle -N sudo-command-line
# #定义快捷键为： [Esc] [Esc]
# bindkey "\e\e" sudo-command-line
# #}}}

# {{{1 command aliases
alias luvit='~/appwill/public/luvit/build/luvit'
alias luajit='rlwrap luajit'
alias  cp='cp -i'
alias  mv='mv -iv'
alias  rm='rm -v'
alias  ls='ls --color -F'
alias  ll="ls -G -l"
alias  grep='grep --color=auto'
alias  e="emacsclient -n"
alias  B='|sed -r "s:\x1B\[[0-9;]*[mK]::g"'
alias  N="*(oc[1])"
alias  wgetpaste='wgetpaste -s ca'
#alias  mocp='mocp ~/foo.playlist.m3u'
# alias -g DISTCC="MAKEOPTS=\"-j13\" FEATURES=\"distcc\""
alias shutdown='sudo /sbin/shutdown -h now'
alias lunar='lunar --utf8'
alias fm='mplayer "http://pri.kts-af.net/redir/index.pls?esid=eb4f5f80569dabe3f640c7ca07676606&url_no=1&client_id=7&uid=68efed4d03ec7e45fd3978262c107180&clicksrc=xml"'
alias dpmsoff='xset dpms force off'
alias gpg='DISPLAY="" gpg'
alias sudomount='sudo /bin/mount -o loop -t squashfs'
alias umount='sudo umount'
alias lsmac="/sbin/ifconfig -a | sed '/eth\|wl/!d;s/ Link.*HWaddr//'"
alias rsync='rsync --progress --partial'
alias po2db=~'/gits/po2db/po2db.pl'
alias adb='/home/cfy/temp/android/android-sdk-linux_x86/platform-tools/adb'
alias ss='/usr/bin/import -frame /dev/shm/screen-shot.jpg && opera /dev/shm/screen-shot.jpg'
alias matlab='~/.local/MATLAB/R2011a/bin/matlab'
alias sbcl="rlwrap sbcl"
alias tar="tar --owner 0 --group 0"
alias maxima="PATH='/home/cfy/perl5/bin:/usr/local/bin:/usr/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.5.3:/usr/games/bin' rlwrap maxima"
alias git_br_d_all='git co master && git branch --merged | grep -v "\*" |grep -v "master"| while read i;do git branch -d $i;git push origin :$i;done'
# alias ccl='/home/cfy/temp/ccl/lx86cl64'
# alias ecl='/usr/lib/ecl/ecl-original'
# }}}1

# {{{1 path aliases
# cd ~p <=> cd /home/ray/projects
# hash -d c="/mnt/C"
# hash -d d="/mnt/D"
# hash -d ptg="/usr/portage"
# hash -d x="/etc/X11"
# hash -d a="/home/ray/algo"
hash -d p="$HOME/Undergraduate/graduate-project/sources/graduate-project/"
hash -d a="$HOME/appwill/private/"
# }}}1




RESET='[00m'
RED='[01;31m'
GREEN='[01;32m'
YELLOW='[01;33m'
BLUE='[01;34m'
MAGENTA='[01;35m'
CYAN='[01;36m'
WHITE='[01;37m'
UNDERLINE='[04m'

get_hg_repos_id()
{
  hg id -bint 2> /dev/null
}

get_git_repos_branch()
{
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}

repos_info()
{
  HG_REPOS_ID="$(get_hg_repos_id)"
  if [ "${HG_REPOS_ID}" ]
  then
    echo "\n\e${WHITE}[\e${CYAN}Mercurial\e${WHITE}] Revision ID \e${YELLOW}${HG_REPOS_ID}"
  else 
    GIT_REPOS_BRANCH="$(get_git_repos_branch)"
    if [ "${GIT_REPOS_BRANCH}" ]
    then
      echo "\n%{\e${WHITE}%}[%{\e${CYAN}%}Git%{\e${WHITE}%}] Current Branch %{\e${YELLOW}%}${GIT_REPOS_BRANCH}"
    else
      echo
    fi
  fi
}

get_repos_info()
{
    echo "$(repos_info)"
}

my_prompt()
{
    echo -en "\e${WHITE}[\e${CYAN}Login\e${WHITE}] \e${GREEN}%n \e${RESET}at \e${WHITE}%m \e${RESET}in \e${BLUE}%d"
    echo
    echo "%{\e${RED}%}%# %{\e${RESET}%}"
}

autoload -U promptinit colors
promptinit
colors

typeset -ga chpwd_functions
chpwd_functions+='get_repos_info'
export PROMPT="$(my_prompt)"

MAIL=/var/spool/mail/ray && export MAIL

export LESSOPEN='|lesspipe %s'

#force rehash when command not found
#  http://zshwiki.org/home/examples/compsys/general
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we did not really complete anything
}

# user defined functions
idcheck_cfy(){perl -le '@a=split //,lc@ARGV[0];@b=split //,lc"79a584216379a5842";$s+=$a[$_]*hex $b[$_] for (0..$#a);$c=((12-($s%11))%11==10?"x":(12-($s%11))%11);unless(@a==18){print $c}else{print +($c eq $a[$#a])?"y":"n"}' $1}
browse(){
    e -e "(browse-url \"$1\")"
}

# LS_COLORS
eval `dircolors`
