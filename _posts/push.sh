#!/bin/sh
echo "Argument:->"  $1
git add --all
git commit -m  $1
git push -u origin master