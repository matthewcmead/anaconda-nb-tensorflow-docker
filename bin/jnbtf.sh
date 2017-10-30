#!/usr/bin/env bash

if [ $# != 1 ]; then
  echo "Usage: $0 <up|down>"
  exit 1
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

JNBDIR="$(cd "$DIR" && cd .. && pwd)"

if [ "$1" == "up" ]; then
  cd $JNBDIR
  docker-compose up --build -d
  URL=""
  while [ "X$URL" == "X" ]; do
    URL="$(docker-compose logs anaconda-nb | grep "http://localhost.*token" | sed "s/.*http/http/")"
    sleep 1
  done
  open "$URL"
elif [ "$1" == "down" ]; then
  cd $JNBDIR
  docker-compose down
else
  echo "Usage: $0 <up|down>"
  exit 1
fi

