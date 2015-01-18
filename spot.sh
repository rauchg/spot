#!/usr/bin/env bash

version="0.2.1"

# search directory defaults to current
dir=.

# Exclude directories
exclude="! -path '*/.git*' ! -path '*/.hg*' ! -path '*/.svn*'"

# case sensitive search
sensitive=

# colors enabled by default in ttys
if [ -t 1 ]; then
  colors=1
else
  colors=
fi

# show matches by default
showmatches=1

# file name pattern
filename=

# line numbers shown by default
linenums=1

# ansi colors
cyan=$(echo -e '\033[96m')
reset=$(echo -e '\033[39m')

# max line length
mline=500

# usage info
usage() {
  cat <<EOF

  Usage: spot [options] [directory] [term ...]

  Options:
    -e, --exclude [dir]     Exclude directory from search
    -s, --sensitive         Force case sensitive search.
    -i, --insensitive       Force case insensitive search.
    -f, --file              Only search file names matching the provided pattern
    -C, --no-colors         Force avoid colors.
    -l, --filenames-only    Only list filenames with matches.
    -L, --no-linenums       Hide line numbers.
    -U, --update            Update spot(1)
    -V, --version           Output version
    -h, --help              This message.
    --                      End of options

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
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case $1 in
    -V | --version )
      echo $version
      exit
      ;;
    -e | --exclude )
      shift; edir=$1;
      exclude="$exclude ! -path '*/$edir*'"
      ;;
    -s | --sensitive )
      sensitive=1
      ;;
    -i | --insensitive )
      sensitive=
      ;;
    -f | --file )
      shift; ffile=$1;
      filename=$ffile
      ;;
    -C | --no-colors )
      colors=
      ;;
    -l | --filenames-only )
      showmatches=
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
if [[ "$1" == "--" ]]; then shift; fi

# check for directory as first parameter
if [[ "$1" =~ / ]]; then
  if [ -d "$1" ]; then
    dir=${1/%\//}
    shift
  fi
fi

# check for empty search
if [ -z "$@" ]; then
  echo "(no search term. \`spot -h\` for usage)"
  exit 1
fi

# auto-detect case sensitive based on an uppercase letter
if [[ "$@" =~ [A-Z] ]]; then
  sensitive=1
fi

# grep default params
grepopt=( --binary-files=without-match --devices=skip )

# add case insensitive search
if [ ! $sensitive ]; then
  grepopt[${#grepopt[*]}]="--ignore-case"
fi

# add filename only options
if [ ! $showmatches ]; then
  grepopt[${#grepopt[*]}]="-l"
fi

# add line number options
if [ $linenums ]; then
  grepopt[${#grepopt[*]}]="-n"
fi

# add force colors
if [ $colors ]; then
  grepopt[${#grepopt[*]}]="--color=always"
fi

# find default params
findopt=

if [ "$filename" ]; then
  findopt="$findopt -name $filename"
fi

# run search
eval "find $dir $findopt -type f $exclude -print0" \
  | GREP_COLOR="1;33;40" xargs -0 grep "${grepopt[@]}" -e "$@" \
  | sed "s/^\([^:]*:\)\(.*\)/  \\
$cyan\1$reset  \\
\2 /" \
  | awk -v linenums=$linenums -v reset="$(tput sgr0)" -v colors=$colors -v mline=$mline '{
  if (length($0) > mline) {
    # Get line number string
    i = index($0, ":")
    linenum = substr($0, 1, i)

    # Loop through all individual matches
    i = index($0, "\033[1;33;40m")
    str = $0
    while(i > 0) {
      # Clean coloring
      line = reset

      if (linenums) {
        line = line linenum reset
      }

      # Build match string with `...` in front if not beginning of line and `...` in the tail
      if (i > 3) {
        line = line "..."substr(str, i - (mline / 2), mline)"..."
      } else {
        line = line substr(str, i, (mline / 2))"..."
      }

      # Strip colors if colors are disabled
      if (colors != 1) {
        gsub(/\033\[0m/, "", line)
        gsub(/\033\[1;33;40m/, "", line)
      }

      # Move window
      str = substr(str, i + (mline / 2))
      i = index(str, "\033[1;33;40m")

      # Show string
      print line
    }

  } else {
    # Strip colors if colors are disabled
    if (colors != 1) {
      gsub(/\033\[0m/, "", $0)
      gsub(/\033\[1;33;40m/, "", $0)
    }

    print $0
  }
  }'

echo ""
tput sgr0 # Clean leftover colors
