#!/bin/bash

[ "$1" = "-u" ] &&  git submodule update --init --recursive
[ "$1" = "pull" ] &&  git submodule foreach git pull
[ "$1" = "checkout" ] &&  git submodule foreach git checkout master

############################### submodules [subdir/file_name] ########################################
subdir=submodules
submodules=("
https://github.com/geekan/scrapy-examples.git
https://github.com/gnemoug/distribute_crawler.git
https://github.com/paoloo1995/scrapy-vue.git
https://github.com/leyle/163spider.git
")

remove_submodules=("
")

### 1.添加 modules
for url in $submodules; do
  # git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user_name=${name_all##*:}             # tufu9441
  file_name=$(basename $url .git)       # maupassant-hexo

  [ -d $subdir/$file_name ] || git submodule add --force $url $subdir/$file_name

done
###  移除 modules
for url in $remove_submodules; do
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user_name=${name_all##*:}             # tufu9441
  file_name=$(basename $url .git)       # maupassant-hexo

  [ -d $subdir/$file_name ] &&( git submodule deinit -f $subdir/$file_name && git rm --cached $subdir/$file_name && rm -rf $subdir/$file_name .git/modules/$subdir/$file_name )

done
############################# submodules [subdir/user_name] #######################################

subdir=submodules

submodules=("
")

remove_submodules=("
")
### 1.添加submodules
for url in $submodules; do
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user_name=${name_all##*:}             # tufu9441
  file_name=$(basename $url .git)       # maupassant-hexo
  [ -d submodules/$user_name ] || git submodule add --force $url $subdir/$user_name

done

### 2.移除submodules
for url in $remove_submodules; do
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user_name=${name_all##*:}             # tufu9441
  file_name=$(basename $url .git)       # maupassant-hexo
  [ -d $subdir/$user_name ] && ( git submodule deinit -f $subdir/$user_name && git rm --cached $subdir/$user_name && rm -rf $subdir/$user_name .git/modules/$subdir/$user_name )

done
##############################> subtrees [subdir/user_name] <######################################
subdir=subtrees

subtrees=("
")

remove_subtrees=("
")
### 1.添加subtrees
for url in $subtrees; do
  # echo $subtree submodules/$(basename $subtree .git)
  name_all=$(basename $(dirname $url))
  user_name=${name_all##*:}
  file_name=$(basename $url .git)

  origin_name=$user_name
  [ -d $subdir/$file_name ] || ( git remote add $origin_name $url && git subtree add -P $subdir/$file_name $origin_name master )
done

################################################################################
