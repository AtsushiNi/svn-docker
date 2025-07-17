#!/bin/bash

# リポジトリ親ディレクトリがなければ作成
if [ ! -d "/home/svn/repos" ]; then
    mkdir -p /home/svn/repos
    chown -R svn:svn /home/svn/repos
    chmod -R 770 /home/svn/repos
fi

# デフォルトリポジトリがなければ作成
if [ ! -d "/home/svn/repos/testrepo" ]; then
    cd /home/svn/repos || exit 1
    /usr/bin/svnadmin create testrepo
    chown -R svn:svn testrepo
    chmod -R 770 testrepo
fi

exec /usr/bin/svnserve -d --foreground -r /home/svn/repos --listen-port 3690;
