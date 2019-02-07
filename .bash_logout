# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ] && [ "$(uname)" == "Linux" ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
elif [ "$SHLVL" = 1 ] && [ "$(uname)" == "Darwin" ]; then
    [ -x /usr/bin/clear ] && /usr/bin/clear
fi

