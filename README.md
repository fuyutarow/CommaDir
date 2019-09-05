![](commad.png)
> A modern version of `cd` from now on.

## Installation
```sh
brew install fuyutarow/commad/commad
echo "source $(where commadrc)" >> ~/.bashrc
```

## Usage
```sh
Usage: commad [-n] [+n] [<args>] 
  <no arg>     Change directory HOME and stack PWD to COMMAD_STACK
  <dir>        Change directory <dir> and stack PWD to COMMAD_STACK

  -l, --list   Show COMMAD_STACK
  -c, --clear  Clear COMMAD_STACK
  --version    Print version

  -1           Change previous directory
  -2           Change 2 previous directory
  -n           Change n previous directory
  +1           Change next directory
  +2           Change 2 next directory
  +n           Change n next directory
```

## Recomended
```sh
: cd
alias ,='commad'

: prevd
alias ,,=', -1'
alias ,,,=', -2'
alias ,,,,=', -3'
alias ,,,,,=', -4'
alias ,,,,,,=', -5'

: nextd
alias ,,=', -1'
alias ,.=', +1'
alias ,..=', +2'
alias ,...=', +3'
alias ,....=', +4'
alias ,.....=', +5'

: cd parents
alias ..=', ..'
alias ...=', ../..'
alias ....=', ../../..'
alias .....=', ../../../..'
alias ......=', ../../../../..'
alias ~=', ~'
```
