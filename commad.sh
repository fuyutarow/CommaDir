# change directory
# ================
# # traditional `cd` aliases
# alias ..='cd ..'
# alias ...='cd ../..'
# alias ....='cd ../../..'
# alias .....='cd ../../../..'
# alias ~='cd ~'
# alias -- -='cd -'

# # from now on tonight


# ## Initialize
COMMAD_STACK=${COMMAD_STACK:-$PWD}
COMMAD_POINTER=${COMMAD_POINTER:-0}

function , {
    # , replaced for cd

    # cd HOME if no args
    if [[ $# = 0 ]]; then
        cd $HOME > /dev/null 2>&1
        COMMAD_STACK=${COMMAD_STACK}"\n$HOME"
        (( COMMAD_POINTER += 1 ))

    # cd given args
    elif [ -d "$@" ]; then
        cd $@ > /dev/null 2>&1
        COMMAD_STACK=${COMMAD_STACK}"\n$PWD"
        (( COMMAD_POINTER += 1 ))

    else
        :
    fi
    ,d
}

function ,l {
    # ,l for ls COMMAD_STACK 

    (( i = 0 ))
    echo $COMMAD_STACK | while read line; do
        [[ $i < $COMMAD_POINTER ]] && prefix="- "
        [[ $i > $COMMAD_POINTER ]] && prefix="+ "
        [[ $i = $COMMAD_POINTER ]] && prefix="* "
        echo "$i $prefix$line"
        (( i += 1 ))
    done
}
function ,d {
    # ,d for debug print 

    echo COMMAD_STACK:
    ,l
    echo
    echo COMMAD_POINTER:
    echo $COMMAD_POINTER

    stack_len=$(echo $COMMAD_STACK | wc -l)
    echo CP:$COMMAD_POINTER, SL:$stack_len
}


function prevd {
    # prevd for cd previous directory
    # if [[ $COMMAD_POINTER -le 0 ]] return;
    if (( $COMMAD_POINTER <= 0 )) return;

    (( COMMAD_POINTER -= 1 ))
    (( i = 0 ))
    echo $COMMAD_STACK | while read line; do
        if [[ $i = $COMMAD_POINTER ]]; then
            cd $line
    ,d
            return
        fi
        (( i += 1 ))
    done
}

function nextd {
    # nextd for cd next directory
    # echo CP: $COMMAD_POINTER
    # echo WL: $(echo $COMMAD_POINTER | wc -l)
    stack_len=$(echo $COMMAD_STACK | wc -l)
    if (( $COMMAD_POINTER + 1 >= $stack_len  )) return;

    (( COMMAD_POINTER += 1 ))
    (( i = 0 ))
    echo $COMMAD_STACK | while read line; do
        if [[ $i = $COMMAD_POINTER ]]; then
            cd $line
    ,d
            return
        fi
        (( i += 1 ))
    done
}

function ,c {
    COMMAD_POINTER=0
    COMMAD_STACK=""
    ,d
}

alias ,,='prevd' # change to previous directory.
alias ,.='nextd' # change to next directory.
alias ,s='. ~/commad/commad.sh'
alias ,e='vi ~/commad/commad.sh'

# alias ,,,=', +2'
# alias ,,,,=', +3'
# alias ,,,,,=', +4'
# alias ,,,,,,=', +5'
alias ..=', ..' # change to parent directory.
alias ...=', ../..'
alias ....=', ../../..'
alias .....=', ../../../..'
alias ......=', ../../../../..'
# alias ,l='echo $COMMAD_STACK'
# alias ,c='COMMAD_STACK=""'
# Yes, `cd` stands for comma and dot.
# # for examples
# To type `,` is equivalent to `cd ~`.
# To type `, <dir>` is equivalent to `cd <dir>`.
# To type `,,` is equivalent to `cd -`.
# To type `..` is equivalent to `cd ..`.
