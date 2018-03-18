#!/bin/bash -xe
HUB="2.2.9"

# hubをインストールする
curl -LO "https://github.com/github/hub/releases/download/v$HUB/hub-linux-amd64-$HUB.tgz"
tar -C "$HOME" -zxf "hub-linux-amd64-$HUB.tgz"
export PATH="$PATH:$HOME/hub-linux-amd64-$HUB/bin"

now=$(date "+%Y%m%d%H%M%S")

# リポジトリに変更をコミットする
hub cone "rubima/rubima.github.io" rubima_github_io
cp -r docs/* rubima_github_io/
cd rubima_github_io
hub checkout -b "jekyll_build_${now}"
hub add .
hub commit -m "jekyll build ${now}"

# Pull Requestを送る
hub fork
hub push origin "jekyll_build_${now}
hub pull-request -m "jekyll build ${now}"
cd ..
