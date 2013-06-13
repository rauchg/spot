#!/usr/bin/env bash

version="0.0.1"

# search directory defaults to current
dir=.

# Exclude directories
exclude="! -path '*/.git*' ! -path '*/.svn*'"

# case sensitive search
sensitive=

# extension only search
ext=

# colors enabled by default in ttys
if [ -t 1 ]; then
  colors=1
else
  colors=
fi

# line numbers shown by default
linenums=1

# ansi colors
cyan=`echo -e '\033[96m'`
reset=`echo -e '\033[39m'`

# usage info
usage() {
  cat <<EOF

  Usage: spot [options] [directory] [term ...]

  Options:
    -e, --exclude [dir]     Exclude directory from search
    -s, --sensitive         Force case sensitive search.
    -i, --insensitive       Force case insensitive search.
    -C, --no-colors         Force avoid colors.
    -L, --no-linenums       Hide line numbers.
    -U, --update            Update spot(1)
    -V, --version           Output version
    -h, --help              This message.
    -x, --extension         Search within files that match the extension only.

EOF
}

# update spot(1) via git clone
update() {
  cd /tmp \
    && echo "... updating" \
    && git clone --depth 1 git://github.com/guille/spot.git \
    && cd spot \
    && make install \
    && echo "... updated to $(spot --version)"
  exit
}

# parse options
while [[ "$1" =~ ^- ]]; do
  case $1 in
    -V | --version )
      echo $version
      exit
      ;;
    -e | --exclude )
      shift; edir=$1;
      exclude="$exclude ! -path '*/$edir*'"
      ;;
    -x | --extension )
      shift; x=$1;
      ext="-name '*.$x'"
      ;;
    -s | --sensitive )
      sensitive=1
      ;;
    -i | --insensitive )
      sensitive=
      ;;
    -C | --no-colors )
      colors=
      ;;
    -L | --no-linenums )
      linenums=
      ;;
    -U | --update )
      update
      ;;
    -h | --help )
      usage
      exit
      ;;
  esac
  shift
done

# check for directory as first parameter
if [[ "$1" =~ / ]]; then
  if [ -d "$1" ]; then
    dir=`echo $1 | sed "s/\/$//"`
    shift
  fi
fi

# check for empty search
if [[ "" = "$@" ]]; then
  echo "(no search term. \`spot -h\` for usage)"
  exit 1
fi

# auto-detect case sensitive based on an uppercase letter
if [[ "$@" =~ [A-Z] ]]; then
  sensitive=1
fi

# grep default params
grepopt="--binary-files=without-match --devices=skip"

# add case insensitive search
if [ ! $sensitive ]; then
  grepopt="$grepopt --ignore-case"
fi

# add line number options
if [ $linenums ]; then
  grepopt="$grepopt -n"
fi

# add force colors
if [ $colors ]; then
  grepopt="$grepopt --color=always"
fi

# run search
if [ $colors ]; then
  eval "find "$dir" -type f $exclude $ext -print0" \
    | GREP_COLOR="1;33;40" xargs -0 grep $grepopt "`echo $@`" \
    | sed "s/^\([^:]*:\)\(.*\)/  \\
  $cyan\1$reset  \\
  \2 /"
else
  eval "find "$dir" -type f $exclude $ext -print0" \
    | xargs -0 grep $grepopt "$@" \
    | sed "s/^\([^:]*:\)\(.*\)/  \\
  \1  \\
  \2 /"
fi

echo ""
