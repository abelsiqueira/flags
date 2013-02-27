#!/bin/bash
export char="0"
export green="\033[1;42m\033[1;32m$char\033[0m"
export yellow="\033[1;43m\033[1;33m$char\033[0m"
export blue="\033[1;44m\033[1;34m$char\033[0m"

export ROWS=$[$[$(tput lines)-2]/2]
export COLS=$[$(tput cols)/2]
export scale=$[$COLS/$ROWS + 1]
export alpha=$[$COLS/2]
export beta=$[$ROWS/2]

for ((i = 0; i < $ROWS; i++))
do
  for ((j = 0; j < $COLS; j++))
  do
    x=$[$j - $COLS/2]
    y=$[$i - $ROWS/2]
    if [ $[$x*$x + $scale*$y*$y] -le $[$beta*$beta] ]
    then
      echo -en $blue
    else
      if [ $[$y*$alpha + $x*$beta] -le $[$alpha*$beta] ] &&
         [ $[-$y*$alpha + $x*$beta] -le $[$alpha*$beta] ] &&
         [ $[$y*$alpha + -$x*$beta] -le $[$alpha*$beta] ] &&
         [ $[-$y*$alpha + -$x*$beta] -le $[$alpha*$beta] ]
      then
        echo -en $yellow
      else
        echo -en $green
      fi
    fi
  done
  echo ''
done
