alias gitdiff='git diff --color -b'
alias gitdiffstat='git diff --color -b --stat'
alias gitstatus='git status'
alias gitclean='echo "> git remote prune origin"; git remote prune origin; echo "> git gc"; git gc'

alias em='emacs --no-splash'
alias emnw='emacs --no-splash -nw'
alias replace_recursive_in_files='echo "find . -type f -exec sed -i 's///g' {} \;"'
