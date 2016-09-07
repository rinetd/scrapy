#!/bin/bash
set -e
subtrees=("
")

submodules=("
git@github.com:hailong0707/spider_news_all.git
")

remove_submodules=("
")

### 1.添加submodules
for submodule in $submodules; do
  # git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform

  # echo $(basename $(dirname $submodule)) # git@github.com:jfrazelle
  # name=$(basename $(dirname $submodule))

  echo $(basename $submodule .git)  # spider_news_all
  name=$(basename $submodule .git)
  # echo ${name##*:}  # jfrazelle

  [ -d submodules/${name##*:} ] || git submodule add --force $submodule submodules/${name##*:}

done
# git submodule update --init --recursive
# git submodule foreach git pull
# git submodule foreach git checkout master

### 2.移除submodules
for submodule in $remove_submodules; do
  # git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform

  # echo $(basename $(dirname $submodule)) # git@github.com:jfrazelle
  name=$(basename $(dirname $submodule))
  echo ${name##*:}  # jfrazelle

  [ -d submodules/${name##*:} ] && (git submodule deinit -f submodules/${name##*:} && git rm --cached submodules/${name##*:} && rm -rf submodules/${name##*:} .git/modules/submodules/${name##*:} )

done

### 3.
for subtree in $subtrees; do
  echo $subtree submodules/$(basename $subtree .git)
done
