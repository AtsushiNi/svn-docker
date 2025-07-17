#!/bin/bash

# リポジトリ親ディレクトリがなければ作成
if [ ! -d "/home/svn/repos" ]; then
    mkdir -p /home/svn/repos
    chown -R svn:svn /home/svn/repos
    chmod -R 770 /home/svn/repos
fi

# デフォルトリポジトリがなければ作成
if [ ! -d "/home/svn/repos/testrepo" ]; then
    /usr/bin/svnadmin create /home/svn/repos/testrepo
    chown -R svn:svn /home/svn/repos/testrepo
    chmod -R 770 /home/svn/repos/testrepo
fi

exec /usr/bin/svnserve -d --foreground -r /home/svn/repos --listen-port 3690;
