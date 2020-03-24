#!/bin/sh
git add --all
git commit -m  ${args[0]}
git push -u origin master