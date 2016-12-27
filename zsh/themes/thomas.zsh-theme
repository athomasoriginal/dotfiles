# =============================================================================
# Custom Theme
# =============================================================================


# Functions
# =============================================================================

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '➜'
}

# Colors
# =============================================================================

if tput setaf 1 &> /dev/null; then
    tput sgr0; # reset colors
    bold=$(tput bold);
    reset=$(tput sgr0);
    # Solarized colors, taken from http://git.io/solarized-colors.
    black=$(tput setaf 0);
    blue=$(tput setaf 33);
    cyan=$(tput setaf 37);
    green=$(tput setaf 64);
    orange=$(tput setaf 166);
    purple=$(tput setaf 125);
    red=$(tput setaf 124);
    violet=$(tput setaf 61);
    white=$(tput setaf 15);
    yellow=$(tput setaf 136);
else
    bold='';
    reset="\e[0m";
    black="\e[1;30m";
    blue="\e[1;34m";
    cyan="\e[1;36m";
    green="\e[1;32m";
    orange="\e[1;33m";
    purple="\e[1;35m";
    red="\e[1;31m";
    violet="\e[1;35m";
    white="\e[1;37m";
    yellow="\e[1;33m";
fi;

# Conditional Colors
# =============================================================================

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
    userStyle="${bold}${red}";
else
    userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
    hostStyle="${bold}${red}";
else
    hostStyle="${yellow}";
fi;

# when the return is success, show a white ➜ otherwise show a red ➜
local ret_status="%(?:%{$fg[white]%}➜ :%{$fg[red]%}➜ )"

# ZSH Git Constants
# =============================================================================

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="${bold}${cyan} [+]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"

# Prompt
# =============================================================================

# username
PROMPT='${userStyle}%n%{$reset_color%} '
# at
PROMPT+='${bold}${white}at%{$reset_color%} '
# hostname
PROMPT+='${hostStyle}%m%{$reset_color%} '
# in
PROMPT+='${bold}${white}in%{$reset_color%} '
# working path
PROMPT+='${green}$(collapse_pwd)%{$reset_color%} '
# on
PROMPT+='${bold}${white}on%{$reset_color%} '
# git branch
PROMPT+='$(git_prompt_info)'
# newline + prompt character
PROMPT+='
${ret_status}%{$reset_color%}'

