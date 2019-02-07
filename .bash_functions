
# cd into directory and then list contents
cl() { cd "$@" && ls -ltr; }

# make directory then cd into it
function mkd() {
  mkdir -p "$*" && cd "$*"
}

# go back n directories
b() {
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

# uncompress all the different things
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# compress all the different things
roll() {
    if [ "$#" -ne 0 ] ; then
      FILE="$1"
      case "$FILE" in
        *.tar.bz2 | *.tbz2) shift && tar cjf "$FILE" $* ;;
        *.tar.gz  | *.tgz)  shift && tar czf "$FILE" $* ;;
        *.tar)              shift && tar cf "$FILE" $*  ;;
        *.zip)              shift && zip "$FILE" $*     ;;
        *.gz)               shift && gzip "$FILE" $*    ;;
        *.rar)              shift && rar "$FILE" $*     ;;
        *.7z)               shift && 7zr a "$FILE" $*   ;;
        *)                  shift && tar cjf "$FILE.tar.bz2" "$FILE" ;;
       #*)                  echo "'$1' cannot be rolled via roll()" ;;
      esac
    else
      echo "usage: roll [file] [contents]"
    fi
}

xfer_key() {
    cat ~/.ssh/id_rsa.pub | ssh "$@" "mkdir -p ~/.ssh/;
    cat >> ~/.ssh/authorized_keys;
    chmod 700 ~/.ssh/;
    chmod 600 ~/.ssh/authorized_keys"
}

psgrep() {
   ps aux | grep $1 | grep -v grep
}

pskill() {
   local pid
 
   pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
   echo -n "Killing $1 (process $pid)... "
   kill -9 $pid
   echo "$pid slaughtered. "
}

# lftp parallel downloads
lftp2() {
    lftp -c "pget -c -n 2 $1"
}

lftp3() {
    lftp -c "pget -c -n 3 $1"
}

lftp4() {
    lftp -c "pget -c -n 4 $1"
}

# fast find, using globstar (bash 4??)
ff(){
    ls -ltr **/$@
}

# top 5, bottom 5 lines
# Note, ht is a tex command - so don't use it as an alias like in ~/.Rprofile :-(
inspect() {
    (head -n 5; tail -n 5) < "$1" | column -t
}

lc() { tr '[:upper:]' '[:lower:]'; }
uc() { tr '[:lower:]' '[:upper:]'; }

genpass() {
   tr -dc 'a-zA-Z0-9_#@,;/\=!$%^&()[]{}' < /dev/urandom | head -c ${1:-16}
   echo
}

function taocl() {
    curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md |
        pandoc -f markdown -t html |
        xmlstarlet fo --html --dropdtd |
        xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" |
        xmlstarlet unesc | fmt -80
}

