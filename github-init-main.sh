#!/usr/bin/env bash

### Decription
# This script simply creates a new GitHub repository from the cli that defaults to using a branch called "main" (vs "master").

### Dependencies
# This script makes use of:
# - git
# - gh (https://github.com/cli/cli)

### Usage
# script '[REPO NAME]' '[REPO DESCRIPTION]'
# Note - you will want to quote your description, etc.

ME=$(basename "$0")

show-usage() {
    echo "USAGE: $ME '[REPO NAME]' '[REPO DESCRIPTION]'"
    echo "exiting..."
    exit 1
}

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    show-usage
fi

if [ -z "$1" ]
  then
    echo "No repo name provided"
    show-usage
fi

if [ -z "$2" ]
  then
    echo "No repo description provided"
    show-usage
fi


mkdir -p $HOME/tmp/$1 && cd $HOME/tmp/$1
git init
gh repo create -d "$2" --public
git remote set-url origin git@github.com:bashfulrobot/$1.git
git checkout -b main
echo "$2" >> README
git add README
git commit -a -m "🎉 Initial Commit"
git push --set-upstream origin main
git branch -D master
git fetch --prune