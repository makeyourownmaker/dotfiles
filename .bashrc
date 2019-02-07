
# Source bash exports
if [ -f $HOME/.bash_exports ]; then
    . $HOME/.bash_exports
fi

# Source bash aliases
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# Source mysql aliases
#if [ -f $HOME/.mysql_aliases ]; then
#    . $HOME/.mysql_aliases
#fi

# Source bash functions
if [ -f $HOME/.bash_functions ]; then
    . $HOME/.bash_functions
fi

# Source bash local environment, aliases, functions
if [ -f $HOME/.bash_local ]; then
    . $HOME/.bash_local
fi


# bash shopts
if [ $BASH_VERSINFO == 4 ]; then 
  shopt -s cdspell      # correct dir spelling errors on cd
  shopt -s autocd       # if a command is a dir name, cd to it (bash 4??)
  shopt -s globstar     # ** matches all files, dirs and subdirs (bash 4??)
fi

shopt -s extglob      # extended pattern matching features
shopt -s histappend   # merge session histories
shopt -s checkwinsize # resize ouput to fit window

