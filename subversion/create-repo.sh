#!/bin/bash

# リポジトリ親ディレクトリがなければ作成
if [ ! -d "/home/svn/repos" ]; then
    mkdir -p /home/svn/repos
    chmod -R 777 /home/svn
    chmod -R 777 /home/svn/repos
fi

# デフォルトリポジトリがなければ作成
rm -rf /home/svn/repos/testrepo
if [ ! -d "/home/svn/repos/testrepo" ]; then
    cd /home/svn/repos || exit 1
    /usr/bin/svnadmin create testrepo
    chmod -R 777 testrepo
fi
chmod -R 777 /home/svn/repos/testrepo

mkdir -p /tmp/init
echo "init" > /tmp/init/README.txt
svn import /tmp/init file:///home/svn/repos/testrepo -m "Initial import"
ls /home/svn/repos/testrepo
