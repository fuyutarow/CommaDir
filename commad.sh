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

function repeat() {
    number=$1
    shift
    for n in $(seq $number); do
      $@
    done
}

# ## Initialize
COMMAD_STACK=${COMMAD_STACK:-$PWD}
COMMAD_POINTER=${COMMAD_POINTER:-0}

function STACK_LEN {
    $(echo $COMMAD_STACK | wc -l)
}

function , {
    # , replaced for cd

    if [[ $# = 0 ]]; then
        cd $HOME
    else
        cd $@
        COMMAD_STACK=$(echo $COMMAD_STACK | head -$(( $COMMAD_POINTER + 1 )) )
    fi
    [[ $PWD = $OLDPWD ]] && return;

    COMMAD_STACK=${COMMAD_STACK}"\n$PWD"
    (( COMMAD_POINTER += 1 ))
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
}


function _prevd {
    # prevd for cd previous directory

    if (( $COMMAD_POINTER <= 0 )) return;

    (( COMMAD_POINTER -= 1 ))
    (( i = 0 ))
    echo $COMMAD_STACK | while read line; do
        if [[ $i = $COMMAD_POINTER ]]; then
            cd $line
            return
        fi
        (( i += 1 ))
    done
}

function prevd {
    [[ "$1" =~ ^[0-9]+$ ]] && n=$1 || n=0
    repeat $n _prevd
}

function _nextd {
    # nextd for cd next directory

    stack_len=$(echo $COMMAD_STACK | wc -l)
    if (( $COMMAD_POINTER + 1 >= $stack_len )) return;

    (( COMMAD_POINTER += 1 ))
    (( i = 0 ))
    echo $COMMAD_STACK | while read line; do
        if [[ $i = $COMMAD_POINTER ]]; then
            cd $line
            return
        fi
        (( i += 1 ))
    done
}

function nextd {
    [[ "$1" =~ ^[0-9]+$ ]] && n=$1 || n=0
    repeat $n _nextd
}

function ,c {
    # clear COMMAD_STACK and COMMAD_POINTER

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
