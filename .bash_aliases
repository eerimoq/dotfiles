alias gitdiff='git diff'
alias gitdiffstat='git diff --stat'
alias gitstatus='git status'
alias gitclean='echo "> git remote prune origin"; git remote prune origin; echo "> git gc"; git gc'
alias gitlog='git log --oneline --decorate=full'

alias em='emacs --no-splash'
alias emnw='emacs --no-splash -nw'
alias replace_recursive_in_files='echo "find . -type f -exec sed -i 's///g' {} \;"'
