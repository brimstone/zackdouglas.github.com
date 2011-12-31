#!/bin/bash
set -eb

_W=

while getopts ":w" opt; do
  case $opt in
  w)
    _W=$EDITOR
    ;;
  esac
done

_now=`date '+%Y-%m-%d'`
echo -n "Post title "
read title
_title=$title
_title=`echo $_title|tr ' ' _`

postdir='_posts'
if [ ! -d $postdir ]; then
  echo "Posts directory not found at ${postdir}" && exit 1
fi

postfile=${_now}-${_title}.md
newpost=$postdir/$postfile

if [ -f $newpost ]; then
  echo "Post already exists!" && exit 1
fi
echo -en "---\nlayout: post\ntitle: $title\nexcerpt: \n---\n" > $newpost
if [ $_W ]; then
  $_W $newpost
fi

echo "Created ${newpost}, enjoy!"
exit 0