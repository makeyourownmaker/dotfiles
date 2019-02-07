
# ls aliases
# enable color support of ls and also add handy aliases
if [ "$(uname)" == "Darwin" ]; then
    alias ls='ls -GF'
elif [ "$(uname)" == "Linux" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto -F'
fi

alias ll='ls -l'
alias la='ls -A'
alias lr='ls -ltrh'
alias l1='ls -1'

# cd aliases
alias cd-='cd -'
alias cd..='cd ..'
alias cd...='cd ../..'
alias mkdir='mkdir -p'

# plotting aliases
alias datafart='curl --data-binary @- datafart.com'
# quick plot of numbers on stdin. Can also pass plot params.
# E.G: seq 1000 | sed 's/.*/s(&)/' | bc -l | plot linecolor 2
plot() { { echo 'plot "-"' "$@"; cat; } | gnuplot -persist; }

# misc aliases
alias q='exit'
alias psall='ps auxww'

alias nseq='grep -c '\''^>'\'''
alias diff-side-by-side='colordiff --side-by-side --suppress-common-lines -W"`tput cols`"'
alias diff-side-by-side-all='colordiff --side-by-side -W"`tput cols`"'

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
# https://github.com/Siilwyn/my-dotfiles/blob/master/.my-dotfiles/readme.md
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Note, shuf/gshuf diff below
if [ "$(uname)" == "Linux" ]; then
  alias hr='printf $(printf "\e[$(shuf -i 91-97 -n 1);1m%%%ds\e[0m\n" $(tput cols)) | tr " " ='
elif [ "$(uname)" == "Darwin" ]; then
  alias hr='printf $(printf "\e[$(gshuf -i 91-97 -n 1);1m%%%ds\e[0m\n" $(tput cols)) | tr " " ='
fi

# WARNING: following will cause problems when reading very large files
alias less='less -s -M +Gg'

# Resume wget by default
alias wget='wget -c'

# Open current directory in browser
alias server='open http://localhost:8000/ && python -m SimpleHTTPServer 8000'

