#!/bin/bash
set -e
subtrees=("
")


modules=("
https://github.com/paoloo1995/scrapy-vue.git
git@github.com:gnemoug/distribute_crawler.git
")

remove_modules=("
")
# ------------------------------------------------------------------------------
submodules=("
https://github.com/geekan/scrapy-examples.git
")

remove_submodules=("
  git@github.com:hailong0707/spider_news_all.git
")
############################### modules ########################################
### 1.添加 modules
for module in $modules; do
  # git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform

  # echo $(basename $(dirname $module)) # git@github.com:jfrazelle
   name=$(basename $(dirname $module))
  # echo $(basename $module .git) # docker-composer
  files=$(basename $module .git)

  # echo ${name##*:}  # jfrazelle
  [ -d ${name##*:}/$files ] || git submodule add --force $module ${name##*:}/$files

done
###  移除 modules
for module in $remove_modules; do
  # git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform

  # echo $(basename $(dirname $module)) # git@github.com:jfrazelle
  name=$(basename $(dirname $module))
  # echo $(basename $module .git) # docker-composer
  files=$(basename $module .git)

  [ -d ${name##*:}/$files ] &&( git submodule deinit -f ${name##*:}/$files && git rm --cached ${name##*:}/$files && rm -rf ${name##*:}/$files .git/modules/${name##*:}/$files )

done
############################# submodules #######################################
### 2.添加submodules
for submodule in $submodules; do
  # git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform

  # echo $(basename $(dirname $submodule)) # git@github.com:jfrazelle
  name=$(basename $(dirname $submodule))
  # echo ${name##*:}  # jfrazelle

  [ -d submodules/${name##*:} ] || git submodule add --force $submodule submodules/${name##*:}

done
# git submodule update --init --recursive
# git submodule foreach git pull
# git submodule foreach git checkout master

### 3.移除submodules
for submodule in $remove_submodules; do
  # git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform

  # echo $(basename $(dirname $submodule)) # git@github.com:jfrazelle
  name=$(basename $(dirname $submodule))
  echo ${name##*:}  # jfrazelle

  [ -d submodules/${name##*:} ] && (git submodule deinit -f submodules/${name##*:} && git rm --cached submodules/${name##*:} && rm -rf submodules/${name##*:} .git/modules/submodules/${name##*:} )

done
##############################> subtrees <######################################
### 4.
for subtree in $subtrees; do
  echo $subtree submodules/$(basename $subtree .git)
done
