source $(which commadrc)
if type "commad" > /dev/null 2>&1; then
    alias ,='commad'
    alias ,,=', -1' # change to previous directory.
    alias ,,,=', -2'
    alias ,,,,=', -3'
    alias ,,,,,=', -4'
    alias ,,,,,,=', -5'
    alias ,.=', +1' # change to next directory.
    alias ,..=', +2'
    alias ,...=', +3'
    alias ,....=', +4'
    alias ,.....=', +5'
else
    alias ,='cd'
fi
alias ..=', ..' # change to parent directory.
alias ...=', ../..'
alias ....=', ../../..'
alias .....=', ../../../..'
alias ......=', ../../../../..'
alias ~=', ~' # change to home directory.

alias ,l='listd' # print $COMMAD_STACK
alias ,c='cleard' # clear $COMMAD_STACK
