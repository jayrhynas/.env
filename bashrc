# .bashrc

# Check if logged in via ssh
if [[ -n "$SSH_TTY" ]] || [[ $(who am i) =~ \([0-9\.]+\)$ ]]; then
    __SSH__=1
fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export HISTFILESIZE=1000
export HISTSIZE=1000
export EDITOR=vim

source $HOME/.env/title

export MANPATH=$MANPATH":/usr/local/man/"

# Add XCode tools to path
if [[ $(uname -s) == "Darwin" ]]; then
    export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin
fi

# Add node.js modules to path
export PATH=$PATH:/usr/local/share/npm/bin/

# Add user bin to path
export PATH=$PATH:$HOME/bin/

# Change bash prompt
source $HOME/.env/colors
if [[ -z $__SSH__ ]]; then
    HOST_COLOR="\[$CYAN$BOLD\]"
    DATE_COLOR="\[$CYAN$NOBOLD\]"
else
    HOST_COLOR="\[$GREEN$BOLD\]"
    DATE_COLOR="\[$GREEN$NOBOLD\]"
fi
INFO_COLOR="\[$YELLOW$BOLD\]"
DELIM_COLOR="\[$RESET_ALL\]"
GIT_DIRTY="\[$RED\]"
GIT_CLEAN="\[$GREEN\]"

function git_ps1() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0;
    fi
    branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    if git diff --quiet 2>/dev/null >&2; then
        color=${GIT_CLEAN}
    else
        color=${GIT_DIRTY}
    fi
    echo " (${color}${branch}\[$RESET_ALL\])"
}

export PROMPT_COMMAND='PS1="${HOST_COLOR}\u@\h ${DATE_COLOR}\D{%a %b %d %Y %T}\n${DELIM_COLOR}[${INFO_COLOR}\w${DELIM_COLOR}]\[${RESET_ALL}\]$(git_ps1) "'

# Forces propmt to start on a new line, even if the previous command
# did not terminate its output with a newline
if [[ "$TERM_PROGRAM" != "DTerm" ]]; then
    source $HOME/.env/newline-fix
else
    export TERM=xterm
fi

# Import aliases
source $HOME/.env/aliases

# Various utilities
source $HOME/.env/util
