gitclean()
{
    echo "> git remote prune origin"
    git remote prune origin
    echo "> git gc"
    git gc
    echo "> rm -rf \`git st -s | awk '/\?\?/ {print \$2}'\`"
    rm -rf `git st -s | awk '/\?\?/ {print $2}'`
}

alias gitdiff='git diff'
alias gitdiffstat='git diff --stat'
alias gitstatus='git status'
alias gitlog='git log --oneline --decorate=full'


alias em='emacs --no-splash'
alias emnw='emacs --no-splash -nw'
alias replace_recursive_in_files='echo "find . -type f -exec sed -i 's///g' {} \;"'
alias emacs='emacs -geometry 100x60 -font 6x13'