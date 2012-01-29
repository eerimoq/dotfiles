# Prompt with git branch and status for bash
#
# Example prompt:
# erik@erik-laptop ~/git/dotfiles 000 master > 
#
# where:
# <user>@<host> <pwd> <to commit><modified unstaged><untracked> <branch> >
#
# <branch> color green -> ahead or at origin
#                cyan  -> behind origin

Q_GREEN="\033[0;32m"
Q_CYAN="\033[0;36m"
Q_WHITE="\033[0;37m"
Q_YELLOW="\033[0;33m"

parse_git_branch()
{
    git_status="$(git status 2> /dev/null)"
    branch_pattern="^# On branch ([^${IFS}]*)"
    branch_behind_remote="# Your branch is behind"
    changes_to_be_committed="# Changes to be committed:"
    changes_not_staged="# Changes not staged for commit:"
    untracked_files="# Untracked files:"
    #Reflects repo working state
    state=
    
    if [[ $git_status =~ $branch_pattern ]]; then
        branch=${BASH_REMATCH[1]}
        
        if [[ $git_status =~ $branch_behind_remote ]]; then
            branch_color=$Q_LIGHT_GREEN
        else
            branch_color=$Q_GREEN
        fi
        if [[ $git_status =~ $changes_to_be_committed ]]; then
            state="1"
        else
            state="0"
        fi
        if [[ $git_status =~ $changes_not_staged ]]; then
            state=$state"1"
        else
            state=$state"0"
        fi
        if [[ $git_status =~ $untracked_files ]]; then
            state=$state"1"
        else
            state=$state"0"
        fi
        if [[ $state == "000" ]]; then
            state_color=$Q_GREEN
        else
            state_color=$Q_YELLOW
        fi
        echo -ne $state_color$state $branch_color$branch" "
    fi
}

PS1="\u@\h \w \$(parse_git_branch)$Q_WHITE> "