#! /usr/local/bin/zsh

DIR=~/Games/IF/Infocom

MENU=()
NAME=()
i=1

GREEN=""
DARKGREEN=""

function border ()
{
  echo -n ${GREEN}
  for i in {0..25}; do 
    echo -n "-=" 
  done 
  echo "-"
  echo -n ${RESET}
}

function title ()
{
  echo -n ${DARKGREEN}
  figlet "Infocom"
  echo -n ${RESET}
}

function menu ()
{
  i=1
  find $DIR -type d \
    | sort -t \( -k 2 -n \
    | tail -n+2 \
    | grep -v zzInvisiclues \
    | while read d; do
        MENU[$i]=$d
        NAME[$i]=`sed 's:^.*/::' <<< $d`
        i=$(( $i + 1 ))
      done
  i=1
  for name in $NAME; do
    echo "${GREEN}[$i]${DARKGREEN} $name"
    i=$(( $i + 1 ))
  done | less -ERX
  echo -n ${RESET}
}

function choose ()
{
  num=""
  while : ; do
    echo -n "ENTER A NUMBER > "
    read num
    [ "x$num" = "xq" ] && echo "Goodbye!" && break
    num=`tr -dc 0-9 <<< "$num" | head -c 3`
    [ -n "$num" ] || continue
    (( $num > $#MENU )) && continue
    cd $MENU[$num]
    frotz *.[zZ][0-9]
  done
}



border
title
border
menu
choose

