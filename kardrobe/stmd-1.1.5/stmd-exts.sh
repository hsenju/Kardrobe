#! /bin/sh
mecab=`/usr/local/bin/mecab-config --exec-prefix`/bin/mecab
exec $mecab '--node-format=%m\n' "$@"
