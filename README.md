# SVN Docker

SVNをDockerで構築するプロジェクト

# 起動方法
```sh
docker-compose up -d
```

# レポジトリの作成方法
Subversionコンテナの中に入って操作を行う
```sh
docker exec -it subversion bash
```
```sh
# /home/svn/repos(svn.confファイルのSVNParentPathで設定した値)のパスに移動
cd /home/svn/repos
# レポジトリの作成。testrepoというディレクトリが存在しない場合には自動で作成される
svnadmin create testrepo
```

# アクセス方法
## ブラウザ
[http://localhost:8080/svn/repos](http://localhost:8080/svn/repos)にアクセス
- 認証情報
    - ユーザー名: `admin`
    - パスワード: `pass`

## CLI
```
brew install subversion
```
```
svn checkout --username admin http://localhost:8080/svn/repos
```

# ユーザー追加方法
1. 例えば一度Subversionのコンテナをビルドして、立ち上げてしまう
```sh
docker-compose up -d
```

2. 立ち上げたコンテナの中に入ってhtpasswdコマンドを実行して、ユーザーとパスワードを作成しておく
```sh
docker exec -it subversion bash
cd /home/svn
```
3. 立ち上げたコンテナ内で"admin"というユーザーIDの初期ユーザーを作成
```sh
htpasswd -c -m localuser.list admin
```
4. もし"admin2"という別のユーザーを追加する場合には -c のオプションを外す
-c のオプションをつけたままだと既存のファイルを削除したうえで新しいファイルが作成されてしまうので注意
```sh
htpasswd -m localuser.list admin2
```

```sh
exit
```
5. この後に先ほど作成したlocaluser.listをホストOSにコピーしてしまう
```sh
docker cp subversion:/home/svn/localuser.list .
```

# 参考サイト
以下サイトに沿って作成した  
[Qiita: httpで通信できLDAP認証もできるSubversionコンテナをDocker上で構築する](https://qiita.com/potashi_chikash/items/de712dbfb68b079cc82b)
