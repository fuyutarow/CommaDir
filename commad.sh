VERSION="2019.09.05"

usage() {
cat<<EOS
Usage: commad [-n] [+n] [<args>] 
  start       Log record When you start
  stop        Log record what and when you end task
  edit        Edit current task
  amend       Edit record
  status      Display tak status
  makebranch  Make a new branch
  checkout    Switch branch
  branch      Show list of branches
  push        Push to your Google Calendar
  open        Open your Google Calendar with web browser
  issue       Open GitHub issue with web browser
  update      Update tak version
EOS
}

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

function commad {
    OPT=$1
    case "$OPT" in
        '-h'|'--help' )
            usage
            ;;
        '--version' )
            echo $VERSION
            ;;
        -*)
            n=$(echo "$OPT" | awk -F'-' '{print $NF}')
            prevd $n
            ;;
        +*)
            n=$(echo "$OPT" | awk -F'+' '{print $NF}')
            nextd $n
            ;;
        *)
            stackd $@
            ;;
    esac
}

function stackd {
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

function listd {
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

function cleard {
    # clear COMMAD_STACK and COMMAD_POINTER

    COMMAD_POINTER=0
    COMMAD_STACK=""
    ,d
}
