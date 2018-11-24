#!/usr/bin/env bash

function usage {
  echo "Usage: $0"
}

function bail {
  echo "$1"
  kill_server
  exit 1
}

trap kill_server INT

function kill_server {
  kill -9 %1
}

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

if [ $(uname) == "Darwin" ]; then
  echo docker.for.mac.localhost >conf/repohost
else
  echo none >conf/repohost
fi

if python --version 2>&1 | grep '^Python 3' >/dev/null; then
  python_http_server="http.server"
elif python --version 2>&1 | grep '^Python 2' >/dev/null; then
  python_http_server="SimpleHTTPServer"
else
  echo "Can't detect python version.  Please ensure python 2 or python 3 is installed and rerun this build script."
  exit 1
fi

cd "$DIR"

python -m "$python_http_server" 8879 &

docker run -it --rm -v "$DIR":/project matthewcmead/anaconda-nb-docker-centos7 /project/getpips.sh
docker build -t matthewcmead/anaconda-nb-docker-tensorflow-centos7 .
kill_server

