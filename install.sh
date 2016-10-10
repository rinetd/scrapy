#!/bin/bash

[ "$1" = "init" ] &&  git submodule update --init --recursive
[ "$1" = "-u" ] &&  git submodule foreach git pull
[ "$1" = "pull" ] &&  git submodule foreach git pull
[ "$1" = "checkout" ] &&  git submodule foreach git checkout master

#     Remove config entries:
#     `git config -f .git/config --remove-section submodule.$submodulepath`
#     `git config -f .gitmodules --remove-section submodule.$submodulepath`
#     Remove directory from index:
#     `git rm --cached $submodulepath`
#     Commit
#     Delete unused files:
#     `rm -rf $submodulepath`
#     `rm -rf .git/modules/$submodulepath`
#
# Please note: $submodulepath doesn't contain leading or trailing slashes.
############################### 1. submodules [user/file] ########################################

submodules=("
")

remove_submodules=("
")

### 1.添加 modules
for url in $submodules; do
  # git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user=${name_all##*:}                  # tufu9441
  file=$(basename $url .git)            # maupassant-hexo

  subdir=$user
  [ -d $subdir/$file ] || git submodule add --force $url $subdir/$file

done
###  移除 modules
for url in $remove_submodules; do
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user=${name_all##*:}                  # tufu9441
  file=$(basename $url .git)            # maupassant-hexo

  subdir=$user
  [ -d $subdir/$file ] &&( git submodule deinit -f $subdir/$file && git rm --cached $subdir/$file && rm -rf $subdir/$file .git/modules/$subdir/$file )

done
############################# 2. submodules [file/user] #######################################

submodules=("
")

remove_submodules=("
")
### 1.添加submodules
for url in $submodules; do
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user=${name_all##*:}                  # tufu9441
  file=$(basename $url .git)            # maupassant-hexo

  subdir=$file
  [ -d $subdir/$user ] || git submodule add --force $url $subdir/$user

done

### 2.移除submodules
for url in $remove_submodules; do
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user=${name_all##*:}                  # tufu9441
  file=$(basename $url .git)            # maupassant-hexo

  subdir=$file
  [ -d $subdir/$user ] && ( git submodule deinit -f $subdir/$user && git rm --cached $subdir/$user && rm -rf $subdir/$user .git/modules/$subdir/$user )

done




############################# 3. submodules [submodules/user] #######################################

submodules=("
")

remove_submodules=("
")
### 1.添加submodules
for url_ext in $submodules; do
  url=$(dirname $url_ext)
  subdir=$(basename $url_ext)
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user=${name_all##*:}                  # tufu9441
  file=$(basename $url .git)            # maupassant-hexo

  [ -d $subdir/$user ] || git submodule add --force $url $subdir/$user

done

### 2.移除submodules
for url_ext in $remove_submodules; do
  url=$(dirname $url_ext)
  subdir=$(basename $url_ext)
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user=${name_all##*:}                  # tufu9441
  file=$(basename $url .git)            # maupassant-hexo

  [ -d $subdir/$user ] && (git submodule deinit -f $subdir/$user && \
                           git rm --cached $subdir/$user && \
                           #  git config -f .gitmodules --remove-section submodule.$subdir/$user dirty && \
                           rm -rf $subdir/$user .git/modules/$subdir/$user )

done
############################### 4. submodules [submodules/file] ########################################

submodules=("
  https://github.com/geekan/scrapy-examples.git/submodules
  https://github.com/gnemoug/distribute_crawler.git/submodules
  https://github.com/paoloo1995/scrapy-vue.git/submodules
  https://github.com/leyle/163spider.git/submodules
  https://github.com/yinzishao/NewsScrapy.git/submodules
  https://github.com/jackgitgz/CnblogsSpider.git/submodules
  https://github.com/ansenhuang/scrapy-zhihu-users.git/submodules
")

remove_submodules=("
")

### 1.添加 modules
for url_ext in $submodules; do
  url=$(dirname $url_ext)
  subdir=$(basename $url_ext)
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user=${name_all##*:}                  # tufu9441
  file=$(basename $url .git)            # maupassant-hexo

  [ -d $subdir/$file ] || git submodule add --force $url $subdir/$file

done
###  移除 modules
for url_ext in $remove_submodules; do
  url=$(dirname $url_ext)
  subdir=$(basename $url_ext)
  name_all=$(basename $(dirname $url))  # git@github.com:tufu9441
  user=${name_all##*:}                  # tufu9441
  file=$(basename $url .git)            # maupassant-hexo

  [ -d $subdir/$file ] &&(git submodule deinit -f $subdir/$file && \
                          git rm --cached $subdir/$file && \
                          # git config -f .gitmodules --remove-section submodule.$subdir/$file dirty && \
                          rm -rf $subdir/$file .git/modules/$subdir/$file )

done
##############################> subtrees [subdir/user] <######################################
subdir=subtrees

subtrees=("
")

remove_subtrees=("
")
### 1.添加subtrees
for url in $subtrees; do
  # echo $subtree submodules/$(basename $subtree .git)
  name_all=$(basename $(dirname $url))
  user=${name_all##*:}
  file=$(basename $url .git)

  origin_name=$user
  # subdir=submodules
  [ -d $subdir/$file ] || ( git remote add $origin_name $url && git subtree add -P $subdir/$file $origin_name master )
done

################################################################################
