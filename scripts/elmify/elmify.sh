#!/bin/bash
function usage {
  echo "Usage: path"
  exit 1
}

[ $# -ne 1 ] && usage


files_path=$(dirname $(realpath $0))/files
path=$1
echo $path
echo $files_path

echo Files to copy:

ls -R $files_path | awk '
/:$/&&f{s=$0;f=0}
/:$/&&!f{sub(/:$/,"");s=$0;f=1;next}
NF&&f{ print s"/"$0 }'

brunchfile=$path/brunch-config.js

[ ! -f $brunchfile ] && echo invalid destination path && usage

echo proceed? [Yn]
read proceed
if [[ $proceed =~ ^[yY]$|^$ ]]; then
  rm $brunchfile
  cp -r $files_path/* $path

  #replace brunch watcher with webpack watcher
  sed -i 's/watchers: *\[.*\] *$/watchers: [npm: ["run-script", "watch"]]/' $path/config/dev.exs

  cd $path
  npm install
  elm-package install -y
fi
