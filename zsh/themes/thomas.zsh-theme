# ------------------------------------------------------------------------------
# Custom Theme
# ------------------------------------------------------------------------------

# disable the terminal window title allowing us to set our custom title
DISABLE_AUTO_TITLE="true"

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# get the current directory's name
function current_directory {
  echo $(basename $(pwd))
}

# collapse the beginning of PWD to `~`
function collapse_pwd {
   echo $(pwd | sed -e "s,^$HOME,~,")
}

# precmd called when each prompt executed.  Inside we are setting the window
# title of the terminal window.  We set it in here to ensure that that the
# window title updates when we move to different directories
function precmd () {
  echo -ne "\033]0;$(current_directory) -- $(hostname)\007"
}

# ------------------------------------------------------------------------------
# Colors
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# Conditional Colors
# ------------------------------------------------------------------------------

# Highlight the user name when logged in as root.
[[ "${USER}" == "root" ]] && userStyle="${bold}${red}" || userStyle="${orange}"

# Highlight the hostname when connected via SSH.
[[ "${SSH_TTY}" ]] && hostStyle="${bold}${red}" || hostStyle="${yellow}"

# when the return is success, show a white ➜ otherwise show a red ➜
local ret_status="%(?:%{$fg[white]%}➜ :%{$fg[red]%}➜ )"

# ------------------------------------------------------------------------------
# ZSH Git Constants
# ------------------------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="${bold}${cyan} [+]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"

# ------------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------------

# example prompt
#   thomas in ~/code/projects/pillar on issue-227-front-end-touchups [+]
#   ➜
#
# Which follows the following structure
#   [username] in [working-dir] on [git-branch-name] [git-modified?]
#   [prompt-char]

# [username]
PROMPT='${userStyle}%n%{$reset_color%} '
# in
PROMPT+='${bold}${white}in%{$reset_color%} '
# [working-dir]
PROMPT+='${green}$(collapse_pwd)%{$reset_color%} '
# on
PROMPT+='${bold}${white}on%{$reset_color%} '
# [git-branch-name]
PROMPT+='$(git_prompt_info)'
# [prompt-char]
PROMPT+='
${ret_status}%{$reset_color%}'
