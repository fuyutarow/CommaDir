![](commad.png)
> A modern version of `cd` from now on.

Support for Bash and Zsh.

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
alias ,,=', -1' # change to previous directory.
alias ,,,=', -2'
alias ,,,,=', -3'
alias ,,,,,=', -4'
alias ,,,,,,=', -5'

: nextd
alias ,.=', +1' # change to next directory.
alias ,..=', +2'
alias ,...=', +3'
alias ,....=', +4'
  
: cd parents
alias ..=', ..' # change to parent directory.
alias ...=', ../..'
alias ....=', ../../..'
alias .....=', ../../../..'
alias ......=', ../../../../..'
alias ~=', ~' # change to home directory.

: status commad
alias ,l='listd' # print $COMMAD_STACK
alias ,c='cleard' # clear $COMMAD_STACK
```
:information: See [examples/.bashrc](examples/.bashrc)

## Examples 

`cd`
```sh
~$ list
dotfiles
~$ , dotfiles
dotfiles$ ,
~$ ,
```

`mkdir`
```sh
~$ , a/b/c/d/e  ;: => mkdir -p a/b/c/d/e
a/b/c/d/e: Not found. Do you make it as dirctory? [y/N] y
~/a/b/c/d/e$ pwd
/Users/fuyutarow/a/b/c/d/e
```

`prevd and nextd`
```sh
~$ , a
~/a$ , b
~/a/b$ , c
~/a/b/c$ , d
~/a/b/c/d$ ,l ;: `listd`
-4  /Users/fuyutarow
-3  /Users/fuyutarow/a
-2  /Users/fuyutarow/a/b
-1  /Users/fuyutarow/a/b/c
*   /Users/fuyutarow/a/b/c/d
~/a/b/c/d$ ,, ;: `prevd` or `, -1`
~/a/b/c$ ,l
-3  /Users/fuyutarow
-2  /Users/fuyutarow/a
-1  /Users/fuyutarow/a/b
*   /Users/fuyutarow/a/b/c
+1  /Users/fuyutarow/a/b/c/d
~/a/b/c$ , -2 ;: `prevd 2` or `, -2`
~/a$ ,. ;: `nextd` or `, +1`
~/a/b$ ,l
-2  /Users/fuyutarow
-1  /Users/fuyutarow/a
*   /Users/fuyutarow/a/b
+1  /Users/fuyutarow/a/b/c
+2  /Users/fuyutarow/a/b/c/d
~/a/b$ , +2 ;: `nextd 2` or `, +2`
~/a/b/c/d$ cat ~/.cd_history
```
